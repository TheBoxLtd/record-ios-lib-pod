//
//  BaseView.m
//  TFLib
//
//  Created by Jano A. on 21/1/15.
//  Copyright (c) 2015 Screenz. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

-(void)show:(BOOL)option animated:(BOOL)animated {
//    self.hidden = !option;
    if(option) {
        [self.superview bringSubviewToFront:self];
    }
    float finalPosition = 0;
    if(!option) {//Hide
        finalPosition = self.frame.size.height;
        //[self.superview sendSubviewToBack:self];
    }
    else {//Show
        //[self setHidden:NO];
        [self.superview bringSubviewToFront:self];
    }
    float duration = 0.5;
    if(!animated) {
        duration = 0;
    }
    [self layoutIfNeeded];
    
    _viewTopConstraint.constant = finalPosition;
    _viewBottomConstraint.constant = -finalPosition;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self layoutIfNeeded];
                     } completion:^(BOOL finished) {
//                         if(!option) {//Hide
//                             [self setHidden:YES];
//                         }
                     }];
}


-(void)setTextsFromDic:(NSDictionary *)dic {
    
}

@end
