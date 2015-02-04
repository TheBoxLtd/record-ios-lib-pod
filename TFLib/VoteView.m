//
//  VoteView.m
//  TFLib
//
//  Created by Jano A. on 21/1/15.
//  Copyright (c) 2015 Screenz. All rights reserved.
//

#import "VoteView.h"
#import "Constants.h"
#import "Utils.h"

@implementation VoteView

-(void)show:(BOOL)option animated:(BOOL)animated {
    [super show:option animated:animated];
    [_btn1 setAlpha:0];
    [_btn2 setAlpha:0];
    [_btn3 setAlpha:0];
    [_btn4 setAlpha:0];
    
    float initialDelay = 0.75;
    float accumulatedDelay = initialDelay;
    float delayStep = 0.5;
    if(![_btn1 isHidden]){
        [self animateButton:_btn1 withDelay:accumulatedDelay];
        accumulatedDelay += delayStep;
    }
    if(![_btn2 isHidden]){
        [self animateButton:_btn2 withDelay:accumulatedDelay];
        accumulatedDelay += delayStep;
    }
    if(![_btn3 isHidden]){
        [self animateButton:_btn3 withDelay:accumulatedDelay];
        accumulatedDelay += delayStep;
    }
    if(![_btn4 isHidden]){
        [self animateButton:_btn4 withDelay:accumulatedDelay];
        accumulatedDelay += delayStep;
    }
    
}

-(void)animateButton:(UIButton*)btn withDelay:(float)delay {
    [UIView animateWithDuration:1 delay:delay options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [btn setAlpha:1.0];
                     } completion:nil];
}

-(void)setTextsFromDic:(NSDictionary *)dic {
    NSArray *buttonArray = [dic objectForKey:STATUS_FRAME_DATA_OPTIONS];
    [_btn1 setHidden:YES];
    [_btn2 setHidden:YES];
    [_btn3 setHidden:YES];
    [_btn4 setHidden:YES];
    
    [_lblTitle setText:[dic objectForKey:STATUS_FRAME_DATA_TITLE]];
    [_lblText setText:[dic objectForKey:STATUS_FRAME_DATA_QUESTION]];
    
    if([buttonArray count] > 1) {
        [_btn1 setHidden:NO];
        [_btn1 setTitle:[buttonArray[0] objectForKey:STATUS_FRAME_DATA_TEXT] forState: UIControlStateNormal];
        [_btn2 setHidden:NO];
        [_btn2 setTitle:[buttonArray[1] objectForKey:STATUS_FRAME_DATA_TEXT] forState: UIControlStateNormal];
    }
    if([buttonArray count] > 2) {
        [_btn3 setHidden:NO];
        [_btn3 setTitle:[buttonArray[2] objectForKey:STATUS_FRAME_DATA_TEXT] forState: UIControlStateNormal];
    }
    if([buttonArray count] > 3) {
        [_btn4 setHidden:NO];
        [_btn4 setTitle:[buttonArray[3] objectForKey:STATUS_FRAME_DATA_TEXT] forState: UIControlStateNormal];
    }
    [self layoutIfNeeded];
    [self setFontSize];
}

-(void)setFontSize {
    if(![Utils isIPhoneDevice]) {
        [Utils setLabel:_lblTitle fontSizeTo:IPAD_TITLE_FONT_SIZE];
        [Utils setLabel:_lblText fontSizeTo:IPAD_TEXT_FONT_SIZE];
        [Utils setLabel:_btn1.titleLabel fontSizeTo:IPAD_BTN_FONT_SIZE];
        [Utils setLabel:_btn2.titleLabel fontSizeTo:IPAD_BTN_FONT_SIZE];
        [Utils setLabel:_btn3.titleLabel fontSizeTo:IPAD_BTN_FONT_SIZE];
        [Utils setLabel:_btn4.titleLabel fontSizeTo:IPAD_BTN_FONT_SIZE];
    }
}

@end
