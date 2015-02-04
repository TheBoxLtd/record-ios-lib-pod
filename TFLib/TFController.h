//
//  TFController.h
//  TFLib
//
//  Created by Jano A. on 11/10/14.
//  Copyright (c) 2014 Screenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TFController : NSObject
+ (TFController *)sharedInstance;

//Only needs to be called once for the entire app lifecycle
-(void)initTFWithView:(UIView*)view token:(NSString *)token uid:(NSString *)uid appid:(NSString*)appid socialNetwork:(NSString*)socialNetwork QA:(BOOL)qa;
@end
