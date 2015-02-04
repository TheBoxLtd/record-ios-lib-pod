//
//  Utils.m
//  Rising Star
//
//  Created by Jano A. on 25/06/14.
//  Copyright (c) 2014 Jano A. All rights reserved.
//

#import "Utils.h"
#import "API.h"
#import "Constants.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation Utils

+(NSDictionary*)getPlistDictionaryWithName:(NSString*)name {
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"TFLib" withExtension:@"bundle"]];
    NSString *plistPath = [bundle pathForResource:name ofType:@"plist"];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return data;
}

+(void)setShareButton:(UIButton *)button asSocialNetwork:(NSString *)socialNetwork {
    NSString *imageName;
    if([socialNetwork isEqualToString:SOCIAL_NETWORK_FACEBOOK]) {
        imageName = @"vote_fb_share_btn";
    }
    if([socialNetwork isEqualToString:SOCIAL_NETWORK_GOOGLE_PLUS]) {
        imageName = @"vote_gp_share_btn";
    }
    if([socialNetwork isEqualToString:SOCIAL_NETWORK_TWITTER]) {
        imageName = @"vote_tw_share_btn";
    }
    if([socialNetwork isEqualToString:SOCIAL_NETWORK_VK]) {
        imageName = @"vote_vk_share_btn";
    }
    if([socialNetwork isEqualToString:SOCIAL_NETWORK_OK]) {
        imageName = @"vote_od_share_btn";
    }

    
    if (imageName) {
//        [button setImage:[Utils loadImageWithName:imageName andExtension:IMAGE_EXTENSION_PNG] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
}

+(void)createBackButtonInView:(UIViewController *)viewController withSelector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:viewController
               action:selector
     forControlEvents:UIControlEventTouchUpInside];
//    [button setImage:[Utils loadImageWithName:SYNC_KEY_MEDIA_BUTTONS_BACK andExtension:IMAGE_EXTENSION_JPG] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    CGSize screenSize = viewController.view.frame.size;
    float resizeRatio = 1;
    if(![Utils isIPhoneDevice]) {
        resizeRatio = 1.75;
    }
    CGSize buttonSize = CGSizeMake(20*resizeRatio, 20*resizeRatio);
    button.frame = CGRectMake(screenSize.width - buttonSize.width*1.5, buttonSize.height*0.5, buttonSize.width, buttonSize.height);
    [viewController.view addSubview:button];
}

+(void)saveToUserDefaults:(id)data withKey:(NSString *)key{
    if(data != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    }
}

+(id)loadFromUserDefaults:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


+(void)saveImage:(UIImage*)image withName:(NSString*)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    if([name rangeOfString:@"png"].location != NSNotFound ) {
        [UIImagePNGRepresentation(image) writeToFile:[documentsDirectory stringByAppendingPathComponent:name] options:NSAtomicWrite error:nil];
    }
    if([name rangeOfString:@"jpg"].location != NSNotFound || [name rangeOfString:@"jpeg"].location != NSNotFound) {
        [UIImageJPEGRepresentation(image,1.0) writeToFile:[documentsDirectory stringByAppendingPathComponent:name] options:NSAtomicWrite error:nil];
    }
}

+ (UIImage*)loadImageWithName:(NSString*)name andExtension:(NSString*)extension
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    name = [name stringByAppendingString:extension];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithString:name] ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}

+(UIColor *)colorFromHexString:(NSString *)string {
    NSScanner *scanner = [NSScanner scannerWithString:string];
    unsigned hex;
    BOOL success = [scanner scanHexInt:&hex];
    if (success) {
        return UIColorFromRGB(hex);
    }
    return [UIColor clearColor];
}

+(BOOL)isIPhoneDevice {
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPad"] ||
       [deviceType isEqualToString:@"iPad Simulator"]) {
        return NO;
    }
    else {
        return YES;
    }
}

+(long)longFromId:(id)num {
    if([num respondsToSelector:@selector(longLongValue)]){
        return [num longLongValue];
    }
    else if([num respondsToSelector:@selector(longValue)]){
        return [num longValue];
    }
    else {
        return (long)num;
    }
}

+(void)setLabel:(UILabel *)label fontSizeTo:(int)size {
    [label setFont:[UIFont fontWithName:label.font.fontName size:size]];
}

+(NSString *)queryWithDictionary:(NSDictionary *)dictionary {
    NSString *query = @"";
    NSArray *keys = [dictionary allKeys];
    for (NSString *key in keys) {
        if([keys indexOfObject:key] != [keys count] - 1) {
            query = [query stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[dictionary objectForKey:key]]];
        }
        else {
            query = [query stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,[dictionary objectForKey:key]]];
        }
    }
    return query;
}

+(NSString *)getImageNameFromURL:(NSString *)url {
    return [url lastPathComponent];
}

 +(NSString *)convertStringIntoMD5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [resultString appendFormat:@"%02x", digest[i]];
    return  resultString;
}

+(NSString *)hashString :(NSString *) data withSalt: (NSString *) salt
{
    NSData *cData = [[salt stringByAppendingString:data] dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(cData.bytes, cData.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}
@end
