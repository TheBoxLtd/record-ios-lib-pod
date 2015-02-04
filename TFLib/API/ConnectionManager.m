//
//  ConnectionManager.m
//  Rising Star
//
//  Created by Jano A. on 17/07/14.
//  Copyright (c) 2014 Jano A. All rights reserved.
//

#import "ConnectionManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constants.h"
#import "API.h"
#import "Utils.h"

@implementation ImageDownloader

-(void)downloadImageFromURL:(NSString *)url withManager:(AFHTTPRequestOperationManager*)manager retrying:(int)ntimes{
    
    if(ntimes <= 0) {
        self.imageError(@"Error requesting image");
    }
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPRequestOperation *postOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    postOperation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [postOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageResult(responseObject);
        });
    }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             [self downloadImageFromURL:url withManager:manager retrying:ntimes - 1];
         });
     }];
    [manager.operationQueue addOperation:postOperation];
}
@end

@implementation ConnectionManager {
    AFHTTPRequestOperationManager *manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        manager = [AFHTTPRequestOperationManager manager];
        [[manager reachabilityManager] startMonitoring];
    }
    return self;
}

-(void)downloadImageFromURL:(NSString*)url withImageResult:(void (^)(UIImage *))imageResult error:(void (^)(NSString *))imageError{
    
    ImageDownloader *imgDownloader = [[ImageDownloader alloc] init];
    
    imgDownloader.imageResult = imageResult;
    imgDownloader.imageError = imageError;
    [imgDownloader downloadImageFromURL:url withManager:manager retrying:MAX_CONNECTION_INTENTS];
}

-(AFHTTPRequestOperation *)request:(NSString*)type url:(NSString *)URLString parameters:(NSDictionary *)parameters lastModified:(NSString *)lastModified customSerializer:(AFHTTPResponseSerializer*)customSerializer success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:type URLString:URLString parameters:parameters error:nil];
    [request setTimeoutInterval:[API getTimeout]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request addValue:[NSString stringWithFormat: @"%lld", [API sharedInstance].lastID]  forHTTPHeaderField:HEADER_LAST_REQUEST_ID];
    [request addValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:HEADER_CLIENT_APP_VERSION];
    if(lastModified != nil && ![lastModified isEqualToString:@""]) {
        [request setValue:lastModified forHTTPHeaderField:@"If-Modified-Since"];
    }
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:success failure:failure];
    if(customSerializer) {
        operation.responseSerializer = customSerializer;
    }
    operation.securityPolicy.allowInvalidCertificates = YES;
    [manager.operationQueue addOperation:operation];
    
    return operation;
}

-(AFHTTPRequestOperation *)request:(NSString*)type url:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    return [self simpleRequest:type url:URLString parameters:parameters customHeaders:nil success:success failure:failure];
}

-(AFHTTPRequestOperation *)requestSecure:(NSString*)type url:(NSString *)URLString parameters:(NSDictionary *)parameters signature:(NSString*)signature success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSDictionary* headers = @{@"X-AUTH":signature};
    return [self simpleRequest:type url:URLString parameters:parameters customHeaders:headers success:success failure:failure];
}

-(AFHTTPRequestOperation *)requestPolling:(NSString*)type url:(NSString *)URLString parameters:(NSDictionary *)parameters forceFirstResponse:(BOOL)forceFirstResponse success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    AFHTTPRequestOperation *operation;
    if(forceFirstResponse){
        operation = [self simpleRequest:type url:URLString parameters:parameters customHeaders:nil success:success failure:failure];
    }
    else{
         operation = [self simpleRequest:type url:URLString parameters:parameters customHeaders:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"RESPONSE: %@ \n %@ \n %@", URLString, [[operation response] allHeaderFields], [operation responseObject]);
            NSString* lastModified = [[[operation response] allHeaderFields] objectForKey:@"Last-Modified"];
            NSString* etag = [[[operation response] allHeaderFields] objectForKey:@"Etag"];
            if(lastModified == nil || etag == nil) {
                NSLog(@"ERROR, NO HEADERS RECEIVED");
                [self requestPolling:type url:URLString parameters:parameters forceFirstResponse:forceFirstResponse success:success failure:failure];
            }
            else {
                NSDictionary *headers = @{@"If-Modified-Since":lastModified, @"If-None-Match":etag};
                [self simpleRequest:type url:URLString parameters:parameters customHeaders:headers success:^(AFHTTPRequestOperation * operation, id responseObject) {
                    NSLog(@"RESPONSE: %@ \n %@ \n %@", URLString, [[operation response] allHeaderFields], [operation responseObject]);
                    //            [self simpleRequest:type url:URLString parameters:parameters customHeaders:nil success:success failure:failure];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success(operation, operation.responseObject);
                    });
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"REQUEST ERROR: %@ \n %@",[[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding],URLString);
                    [self requestPolling:type url:URLString parameters:parameters forceFirstResponse:forceFirstResponse success:success failure:failure];
                }];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"REQUEST ERROR: %@ \n %@",[[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding],URLString);
            [self requestPolling:type url:URLString parameters:parameters forceFirstResponse:forceFirstResponse success:success failure:failure];
        }];
    }
    
    return operation;
    
//    return [self simpleRequest:type url:URLString parameters:parameters customHeaders:nil success:success failure:failure];
    
}

-(AFHTTPRequestOperation *)simpleRequest:(NSString*)type url:(NSString *)URLString parameters:(NSDictionary *)parameters customHeaders:(NSDictionary*)customHeaders success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:type URLString:URLString parameters:parameters error:nil];
    [request setTimeoutInterval:[API getTimeout]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    if(customHeaders != nil) {
        for(id key in customHeaders){
            [request addValue:[customHeaders valueForKey:key]  forHTTPHeaderField:key];
        }
    }
    
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:success failure:failure];
    operation.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.operationQueue addOperation:operation];
    NSLog(@"REQUEST: %@ \n %@", [[operation request] URL], [[operation request] allHTTPHeaderFields]);
    return operation;
    
}

-(BOOL)isNetworkReachable {
    return [[manager reachabilityManager] isReachable];
}

-(void)setReachabilityStatusChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block {
    [[manager reachabilityManager] setReachabilityStatusChangeBlock:block];
}

static ConnectionManager *sharedInstance;
+ (ConnectionManager *)sharedInstance{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^
                  {
                      sharedInstance = [[ConnectionManager alloc] init];
                  });
	
	return sharedInstance;
}
@end
