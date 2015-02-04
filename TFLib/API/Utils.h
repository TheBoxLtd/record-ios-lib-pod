//
//  Utils.h
//  Rising Star
//
//  Created by Jano A. on 25/06/14.
//  Copyright (c) 2014 Jano A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//-----------------------------------------------------------//
//----------------- MACROS
//-----------------------------------------------------------//
#define NSStringFromBool(b) (b ? @"YES" : @"NO")
#define NSStringIsNotEmpty(s) (s != nil && ![s isEqualToString:@""])
#define NSMutableDictionaryAddStringIfNotEmpty(s,key,dic) NSStringIsNotEmpty(s) ? [dic setValue:s forKey:key] : 0
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface Utils : NSObject
+(NSDictionary*)getPlistDictionaryWithName:(NSString*)name;
+(void)setShareButton:(UIButton*)button asSocialNetwork:(NSString*)socialNetwork;
+(void)createBackButtonInView:(UIViewController*)viewController withSelector:(SEL)selector;
+(void)saveToUserDefaults:(id)data withKey:(NSString*)key;
+(id)loadFromUserDefaults:(NSString*)key;
+(void)saveImage:(UIImage*)image withName:(NSString*)name;
+ (UIImage*)loadImageWithName:(NSString*)name andExtension:(NSString*)extension;
+(UIColor*)colorFromHexString:(NSString*)string;
+(BOOL)isIPhoneDevice;
+(long)longFromId:(id)num;
+(void)setLabel:(UILabel*)label fontSizeTo:(int)size;

//String formatting
+(NSString*)queryWithDictionary:(NSDictionary*)dictionary;
+(NSString*)getImageNameFromURL:(NSString*)url;
+(NSString*)formatStringForVoteGA:(NSString*)string;
+(NSString *)convertStringIntoMD5:(NSString *)string;
+(NSString *) hashString :(NSString *) data withSalt: (NSString *) salt;
@end

@interface NSDictionary (UrlEncoding)
-(NSString*) urlEncodedString;
@end
