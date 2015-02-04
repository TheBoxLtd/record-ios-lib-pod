//
//  BaseView.h
//  TFLib
//
//  Created by Jano A. on 21/1/15.
//  Copyright (c) 2015 Screenz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBottomConstraint;

-(void)show:(BOOL)option animated:(BOOL)animated;
-(void)setTextsFromDic:(NSDictionary*)dic;
@end
