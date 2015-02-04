//
//  TextView.m
//  TFLib
//
//  Created by Jano A. on 21/1/15.
//  Copyright (c) 2015 Screenz. All rights reserved.
//

#import "TextView.h"
#import "Constants.h"
#import "Utils.h"

@implementation TextView

-(void)setTextsFromDic:(NSDictionary *)dic {
    [_lblTitle setText:[dic objectForKey:STATUS_FRAME_DATA_TITLE]];
    [_lblText setText:[dic objectForKey:STATUS_FRAME_DATA_TEXT]];
    [self setFontSize];
}

-(void)setFontSize {
    if(![Utils isIPhoneDevice]) {
        [Utils setLabel:_lblTitle fontSizeTo:IPAD_TITLE_FONT_SIZE];
        [Utils setLabel:_lblText fontSizeTo:IPAD_TEXT_FONT_SIZE];
    }
}

@end
