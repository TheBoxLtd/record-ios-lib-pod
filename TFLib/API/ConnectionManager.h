//
//  ConnectionManager.h
//  Rising Star
//
//  Created by Jano A. on 17/07/14.
//  Copyright (c) 2014 Jano A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperation.h"
#import "AFNetworkReachabilityManager.h"

#define CONNECTION_TYPE_GET @"GET"
#define CONNECTION_TYPE_POST @"POST"

typedef void (^imageDownloadResult)(UIImage*);
typedef void (^imageDownloadError)(NSString*);



@interface ConnectionManager : NSObject
-(void)downloadImageFromURL:(NSString*)url
            withImageResult:(void (^)(UIImage *image))imageResult
                    error:(void (^)(NSString *error))imageError;
//-(AFHTTPRequestOperation *)request:(NSString*)type url:(NSString *)URLString parameters:(NSDictionary *)parameters lastModified:(NSString *)lastModified customSerializer:(AFHTTPResponseSerializer*)customSerializer success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
-(AFHTTPRequestOperation *)request:(NSString*)type url:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
-(AFHTTPRequestOperation *)requestSecure:(NSString*)type url:(NSString *)URLString parameters:(NSDictionary *)parameters signature:(NSString*)signature success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
-(AFHTTPRequestOperation *)requestPolling:(NSString*)type url:(NSString *)URLString parameters:(NSDictionary *)parameters forceFirstResponse:(BOOL)forceFirstResponse success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;
-(BOOL)isNetworkReachable;
-(void)setReachabilityStatusChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block;

+ (ConnectionManager *)sharedInstance;
@end

@interface ImageDownloader : NSObject
@property (nonatomic, copy) imageDownloadResult imageResult;
@property (nonatomic, copy) imageDownloadError imageError;
@end
