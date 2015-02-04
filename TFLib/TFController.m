//
//  TFController.m
//  TFLib
//
//  Created by Jano A. on 11/10/14.
//  Copyright (c) 2014 Screenz. All rights reserved.
//

#import "TFController.h"
#import "TFView.h"
#import "API.h"
#import "Constants.h"
#import "Logger.h"
#import <CoreText/CoreText.h>

@implementation TFController {
    BOOL isAlreadyInitiated;
}

-(void)initTFWithView:(UIView*)view token:(NSString *)token uid:(NSString *)uid appid:(NSString*)appid socialNetwork:(NSString*)socialNetwork QA:(BOOL)qa {
    if(isAlreadyInitiated) {
        return;
    }
    isAlreadyInitiated = YES;
    
    [self loadFonts];
    
    CGRect initialFrame = view.frame;
    initialFrame.origin = CGPointZero;
    
    TFView *farmView = [[TFView alloc] initWithFrame:initialFrame];
    [view addSubview:farmView];
    
    if(token != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:USER_DEFAULTS_TOKEN];
    }
    if(uid != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:uid forKey:USER_DEFAULTS_UID];
    }
    if(appid != nil){
        [[NSUserDefaults standardUserDefaults] setObject:appid forKey:USER_DEFAULTS_APPID];
    }
    if(socialNetwork != nil){
        [[NSUserDefaults standardUserDefaults] setObject:socialNetwork forKey:USER_DEFAULTS_SOCIAL_NETWORK];
    }
    
    LOG(@"Starting with token:%@ uid:%@ and QA:%i",token,uid,qa);

    [[API sharedInstance] setIsQAMode:qa];
    [[API sharedInstance] loadStartData];

}

-(void)loadFonts {
    NSArray *fontNames = @[[NSString stringWithFormat:@"/%@.otf",FONT_MYRIAD_REGULAR], [NSString stringWithFormat:@"/%@.otf",FONT_MYRIAD_BOLD]];
    for (NSString* fontName in fontNames) {
        NSString *fontPath = [[[[NSBundle mainBundle] URLForResource:@"TFLib" withExtension:@"bundle"]path] stringByAppendingString:fontName];
        NSData *inData = [[NSFileManager defaultManager] contentsAtPath:fontPath];
        
        CFErrorRef error;
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)inData);
        CGFontRef font = CGFontCreateWithDataProvider(provider);
        if (! CTFontManagerRegisterGraphicsFont(font, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        CFRelease(font);
        CFRelease(provider);
    }
}

static TFController *sharedInstance;
+ (TFController *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedInstance = [[TFController alloc] init];
                  });
    
    return sharedInstance;
}
@end
