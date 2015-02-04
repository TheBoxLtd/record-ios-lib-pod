//
//  MissedView.m
//  TFLib
//
//  Created by Jano A. on 21/1/15.
//  Copyright (c) 2015 Screenz. All rights reserved.
//

#import "MissedView.h"
#import "Constants.h"
#import "Utils.h"

@implementation MissedView

-(void)setTextsFromDic:(NSDictionary *)dic {
    [_lblTitle setText:[dic objectForKey:DATA_KEY_GLOSSARY_VOTING_MISSED_TITLE]];
    [_lblText setText:[dic objectForKey:DATA_KEY_GLOSSARY_VOTING_MISSED_WAITING_TEXT]];
    [self setFontSize];
}

-(void)setFontSize {
    if(![Utils isIPhoneDevice]) {
        [Utils setLabel:_lblTitle fontSizeTo:IPAD_TITLE_FONT_SIZE];
        [Utils setLabel:_lblText fontSizeTo:IPAD_TEXT_FONT_SIZE];
    }
}

@end
