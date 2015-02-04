//
//  TFView.h
//  TFLib
//
//  Created by Jano A. on 11/10/14.
//  Copyright (c) 2014 Screenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDownloadableImageView.h"
#import "AuthView.h"
#import "VoteView.h"
#import "ImageView.h"
#import "TextView.h"
#import "MissedView.h"
#import "ThanksView.h"

typedef enum ViewStatus
{
    VIEW_STATE_NONE,
    VIEW_STATE_TEXT,
    VIEW_STATE_IMAGE,
    VIEW_STATE_ERROR,
    VIEW_STATE_PICAPPROVAL,
    VIEW_STATE_VOTE,
    VIEW_STATE_VOTE_AFTER,
    VIEW_STATE_VOTE_MISSED
} ViewState;

@interface TFView : UIView

//UIViews
@property (weak, nonatomic) IBOutlet AuthView *viewAuthView;
@property (weak, nonatomic) IBOutlet VoteView *viewVoteView;
@property (weak, nonatomic) IBOutlet ImageView *viewImageView;
@property (weak, nonatomic) IBOutlet TextView *viewTextView;
@property (weak, nonatomic) IBOutlet MissedView *viewMissedView;
@property (weak, nonatomic) IBOutlet ThanksView *viewThanksView;



@end