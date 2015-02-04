//
//  UIDownloadableImageView.m
//  Rising Star
//
//  Created by Jano A. on 24/02/14.
//  Copyright (c) 2014 Jano A. All rights reserved.
//

#import "UIDownloadableImageView.h"
#import "API.h"
#import "Utils.h"

@implementation UIDownloadableImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createActivityIndicator];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self createActivityIndicator];
    }
    return self;
}

-(void)createActivityIndicator {
    CGRect frame = self.frame;
    frame.origin = CGPointZero;
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    act.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [act startAnimating];
    
    [self addSubview:act];
    activityIndicator = act;
    
}

- (void)loadImage:(NSString*)url {
    if(url == nil || [url isEqualToString:@""]) {
        return;
    }
    UIImage *image = [self getSavedImageFromURL:url];
    if(image != nil) { //Image is already downloaded
        [self setImage:image];
        [self setLoading:NO];
    }
    else { //Download image
        [self setLoading:YES];
        [self downloadImageFromURL:url success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [Utils saveImage:responseObject withName:[Utils getImageNameFromURL:url]];
            [self setImage:[self getSavedImageFromURL:url]];
            [self setLoading:NO];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self performSelector:@selector(loadImage:) withObject:url afterDelay:[API getInterval]];
            NSLog(@"Error Downlading Image: %@ /n %@ /n %@", [operation response], [[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding], error );
        }];
    }
}

-(UIImage*)getSavedImageFromURL:(NSString*)url {
    if([url rangeOfString:@"http"].location == NSNotFound ) {//Not an url
        UIImage *result = [UIImage imageNamed:url];
        return result;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"Image URL: %@", url);
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", documentsDirectory, [Utils getImageNameFromURL:url]]];
    return result;
}

-(void)downloadImageFromURL:(NSString *)url success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPRequestOperation *postOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    postOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [postOperation setCompletionBlockWithSuccess:success failure:failure];
    [postOperation start];
}

-(void)setLoading:(BOOL)option {
    if(option) {
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        if(!activityIndicator) {
            [self createActivityIndicator];
        }
        [activityIndicator setHidden:NO];
    }
    else {
        [self setBackgroundColor:[UIColor clearColor
                                  ]];
        if(activityIndicator) {
            [activityIndicator setHidden:YES];
            [activityIndicator removeFromSuperview];
            activityIndicator = nil;
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
