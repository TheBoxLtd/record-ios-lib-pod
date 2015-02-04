//
//  AuthView.m
//  TFLib
//
//  Created by Jano A. on 21/1/15.
//  Copyright (c) 2015 Screenz. All rights reserved.
//

#import "AuthView.h"
#import "Constants.h"
#import "Utils.h"

@implementation AuthView


-(void)setTextsFromDic:(NSDictionary *)dic {
    [_lblTitle setText:[dic objectForKey:DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_TITLE]];
    [_lblText setText:[dic objectForKey:DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_SUBTITLE]];
    [_btnYes setTitle:[dic objectForKey:DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_FORM_YES] forState:UIControlStateNormal];
    [_btnNo setTitle:[dic objectForKey:DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_FORM_NO
                                   ] forState:UIControlStateNormal];
    [self setFontSize];
}

-(void)setFontSize {
    if(![Utils isIPhoneDevice]) {
        [Utils setLabel:_lblTitle fontSizeTo:IPAD_TITLE_FONT_SIZE];
        [Utils setLabel:_lblText fontSizeTo:IPAD_TEXT_FONT_SIZE];
        [Utils setLabel:_btnYes.titleLabel fontSizeTo:IPAD_BTN_FONT_SIZE];
        [Utils setLabel:_btnNo.titleLabel fontSizeTo:IPAD_BTN_FONT_SIZE];
    }
}

@end
