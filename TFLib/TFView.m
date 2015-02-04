//
//  TFView.m
//  TFLib
//
//  Created by Jano A. on 11/10/14.
//  Copyright (c) 2014 Screenz. All rights reserved.
//

#import "TFView.h"
#import "Constants.h"
#import "API.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

#define getImageName(name) [@"TFLib.bundle/" stringByAppendingString:name]
#define COLOR_BUTTON_NORMAl [UIColor colorWithRed:230.0f/255.0f green:132.0f/255.0f blue:78/255.0f alpha:1.0f]
#define COLOR_BUTTON_YES [UIColor colorWithRed:139.0f/255.0f green:195.0f/255.0f blue:63.0f/255.0f alpha:1.0f]
#define COLOR_BUTTON_NO [UIColor colorWithRed:227.0f/255.0f green:113.0f/255.0f blue:80.0f/255.0f alpha:1.0f]


@implementation TFView {
    ViewState state;
    ViewState savedState;
    UIView *loadingView;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"TFLib" withExtension:@"bundle"]];
    UIView *rootView = [[bundle loadNibNamed:@"TFMainView" owner:self options:nil] objectAtIndex:0];
    rootView.frame = self.frame;
    [self addSubview:rootView];
    
    [self hideAll];

    
   // [self layoutIfNeeded];
    
    //Rotate image
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationStatusChanged:) name:NOTIFICATION_STATUS_CHANGED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRefreshContent:) name:NOTIFICATION_REFRESH_CONTENT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoaded) name:NOTIFICATION_DATA_LOADED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationShowError:) name:NOTIFICATION_SHOW_ERROR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHideError:) name:NOTIFICATION_HIDE_ERROR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginDone:) name:NOTIFICATION_LOGIN_DONE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginError:) name:NOTIFICATION_LOGIN_ERROR object:nil];
    
    [self loadFonts];
    
    return self;
}

-(void)hideAll{
    [_viewAuthView show:NO animated:NO];
    [_viewImageView show:NO animated:NO];
    [_viewMissedView show:NO animated:NO];
    [_viewTextView show:NO animated:NO];
    [_viewThanksView show:NO animated:NO];
    [_viewVoteView show:NO animated:NO];
}

-(void)loadFonts {
//    UIFont *buttonFont = [UIFont fontWithName:FONT_MYRIAD_BOLD size:[self getFontSizeForDevice:18]];
//    [[_btnOne titleLabel] setFont:buttonFont];
//    [[_btnTwo titleLabel] setFont:buttonFont];
//    [[_btnThree titleLabel] setFont:buttonFont];
//    [[_btnFour titleLabel] setFont:buttonFont];
//    
//    [_lblButtonsTitle setFont:[UIFont fontWithName:FONT_MYRIAD_REGULAR size:[self getFontSizeForDevice:17]]];
//    [_lblHenText setFont:[UIFont fontWithName:FONT_MYRIAD_REGULAR size:[self getFontSizeForDevice:17]]];
//    [_lblErrorText setFont:[UIFont fontWithName:FONT_MYRIAD_REGULAR size:[self getFontSizeForDevice:17]]];
//    [_lblErrorTitle setFont:[UIFont fontWithName:FONT_MYRIAD_BOLD size:[self getFontSizeForDevice:17]]];
//    [_lblTextTitle setFont:[UIFont fontWithName:FONT_MYRIAD_BOLD size:[self getFontSizeForDevice:17]]];
//    [_lblTextText setFont:[UIFont fontWithName:FONT_MYRIAD_REGULAR size:[self getFontSizeForDevice:14]]];
}

#pragma mark - animations

-(void)updateButtonsAnimated:(BOOL)animated{
//    float lblTop = _lblButtonsTitle.frame.origin.y;
//    float logoBot = _imgLogo.frame.origin.y + _imgLogo.frame.size.height;
//    float spacing = 0;
//    if(![Utils isIPhoneDevice]) {
//        spacing = 15;
//    }
//    
//    float h1 = _viewButtons.frame.size.height;
//    float h2 = self.frame.size.height;
//    
//    float finalPosition = lblTop - logoBot - h1 + h2 - spacing;
//
//    [self layoutIfNeeded];
//    
//    _viewButtonsConstraint.constant = finalPosition;
//    
//    if(animated) {
//        [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0f options:UIViewAnimationOptionAllowUserInteraction
//                         animations:^{
//                             [self layoutIfNeeded];
//                         } completion:^(BOOL finished) {
//                         }];
//    }
//    else {
//        [self layoutIfNeeded];
//    }
    
}

-(void)showView:(ViewState)view option:(BOOL)show animated:(BOOL)animated{
    switch (view) {
        case VIEW_STATE_TEXT:
            [_viewTextView show:show animated:animated];
            break;
        case VIEW_STATE_VOTE:
            [_viewVoteView show:show animated:animated];
            break;
        case VIEW_STATE_IMAGE:
            [_viewImageView show:show animated:animated];
            break;
        case VIEW_STATE_ERROR:
            //[_viewMissedView show:show animated:animated];
            break;
        case VIEW_STATE_PICAPPROVAL:
            [_viewAuthView show:show animated:animated];
            break;
        case VIEW_STATE_VOTE_AFTER:
            [_viewThanksView show:show animated:animated];
            break;
        case VIEW_STATE_VOTE_MISSED:
            [_viewMissedView show:show animated:animated];
            break;
        default:
            break;
    }
}

#pragma mark - flow control

- (void) notificationRefreshContent:(NSNotification *) notification {
    if(state == VIEW_STATE_PICAPPROVAL) {
        return;
    }
    [self showLoadingView:NO];
    int status = (int)[[[[API sharedInstance].statusData objectForKey:STATUS_FRAME] objectForKey:STATUS_FRAME_STATUS] integerValue];
    [self showStatus:status];
}

- (void) notificationStatusChanged:(NSNotification *) notification {
    if(state == VIEW_STATE_PICAPPROVAL) {
        return;
    }
    [self showLoadingView:NO];
    //[self hideAll];
    long status = [[[notification userInfo] objectForKey:NOTIFICATION_STATUS_CHANGED] longValue];
    [self showStatus:status];
}

- (void) notificationShowError:(NSNotification *) notification {
    [self setTextsForState:VIEW_STATE_ERROR];
    savedState = state;
    [self changeState:VIEW_STATE_ERROR];
}
- (void) notificationHideError:(NSNotification *) notification {
    if(state == VIEW_STATE_ERROR) {
        [self changeState:savedState];
    }
}

-(void)showStatus:(long)status {
    NSDictionary *frame = [[API sharedInstance].statusData objectForKey:STATUS_FRAME];
    if(status == 11) {
        NSString *type = [frame objectForKey:STATUS_FRAME_TYPE];
        if([type isEqualToString:STATUS_FRAME_TYPE_IMAGE]) {//Image
            [self setTextsForState:VIEW_STATE_IMAGE];
            [self changeState:VIEW_STATE_IMAGE];
        }
        if([type isEqualToString:STATUS_FRAME_TYPE_TEXT]) {//Text
            [self setTextsForState:VIEW_STATE_TEXT];
            [self changeState:VIEW_STATE_TEXT];
        }
        
    }
    else {//Vote
        if(status == 2 || ([API isVoted] && state != VIEW_STATE_VOTE_AFTER)) {
            
            if([API isVoted]) {
                [self setTextsForState:VIEW_STATE_VOTE_AFTER];
                [self changeState:VIEW_STATE_VOTE_AFTER];
            }else {
                [self setTextsForState:VIEW_STATE_VOTE];
                [self changeState:VIEW_STATE_VOTE];
            }
            
        }
        else {
            if(![API isVoted]) {
                [self setTextsForState:VIEW_STATE_VOTE_MISSED];
                [self changeState:VIEW_STATE_VOTE_MISSED];
            }
        }
    }
}

-(void)changeState:(ViewState)newState {
    if(newState == state) {
        if(newState == VIEW_STATE_VOTE && state == VIEW_STATE_VOTE) {
            [self updateButtonsAnimated:YES];
        }
        return;
    }
    else {
        //[self hideAll];
    }
    
    //[self showView:state option:NO animated:YES];
    [self showView:newState option:YES animated:YES];
    state = newState;
}

-(void)setTextsForState:(ViewState)option {
    if(option == VIEW_STATE_IMAGE) {
        NSDictionary *frame = [[API sharedInstance].statusData objectForKey:STATUS_FRAME];
        [_viewImageView setTextsFromDic:frame];
    }
    if(option == VIEW_STATE_TEXT) {
        NSDictionary *frame = [[API sharedInstance].statusData objectForKey:STATUS_FRAME];
        [_viewTextView setTextsFromDic:frame];
    }
    if(option == VIEW_STATE_VOTE) {
        NSDictionary *frame = [[API sharedInstance].statusData objectForKey:STATUS_FRAME];
        [_viewVoteView setTextsFromDic:frame];
    }
    if(option == VIEW_STATE_VOTE_AFTER) {
        NSDictionary *voting = [[API sharedInstance].dataGlossary objectForKey:DATA_KEY_GLOSSARY_VOTING];
        [_viewThanksView setTextsFromDic:voting];
    }
    if(option == VIEW_STATE_VOTE_MISSED) {
        NSDictionary *voting = [[API sharedInstance].dataGlossary objectForKey:DATA_KEY_GLOSSARY_VOTING];
        [_viewMissedView setTextsFromDic:voting];
        
    }
    if(option == VIEW_STATE_PICAPPROVAL) {
        NSDictionary* registration = [[API sharedInstance].dataGlossary objectForKey:DATA_KEY_GLOSSARY_REGISTRATION];
        [_viewAuthView setTextsFromDic:registration];
    }
}

-(void)dataLoaded {
    if (![API isPicApproved]) {
        state = VIEW_STATE_PICAPPROVAL;
        [self setTextsForState:VIEW_STATE_PICAPPROVAL];
        [self showView:state option:YES animated:YES];
    }
    else {
        [[API sharedInstance] start];
        [API doLogIn];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_DATA_LOADED object:nil];
}

-(void)startAPI {
    [[API sharedInstance] start];
}

- (void) loginDone:(NSNotification *) notification {
    [self performSelector:@selector(startAPI) withObject:self afterDelay:1.5];
    [self changeState:VIEW_STATE_NONE];
}

- (void) loginError:(NSNotification *) notification {
    [self showLoadingView:NO];
}

-(void)showLoadingView:(BOOL)option {
    if(option){
        if(loadingView == nil) {
            loadingView = [[UIView alloc] initWithFrame:self.frame];
            loadingView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.0];
        }
        [self addSubview:loadingView];
        [UIView animateWithDuration:1.0f animations:^{
            loadingView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        } completion:nil];
    }
    else {
        if(loadingView != nil) {
            [loadingView removeFromSuperview];
        }
    }
}

#pragma mark - IBActions
- (IBAction)pressedButton:(id)sender {
    if(state == VIEW_STATE_PICAPPROVAL){
        //[self performSelector:@selector(startAPI) withObject:self afterDelay:1.5];
        BOOL approved = NO;
        if(sender == _viewAuthView.btnYes) {
            approved = YES;
        }
        [API picApprove:approved];
        [self showLoadingView:YES];
    }
    else {
        //[_lblHenText setText:[[API sharedInstance].data objectForKey:DATA_KEY_GLOSSARY_VOTING_VOTE_TEXT]];
        [self setTextsForState:VIEW_STATE_VOTE_AFTER];
        [self changeState:VIEW_STATE_VOTE_AFTER];
        
        NSArray *voteData = [[[API sharedInstance].statusData objectForKey:STATUS_FRAME] objectForKey:STATUS_FRAME_DATA_OPTIONS];
        int index = -1;
        if(sender == _viewVoteView.btn1) {
            index = 0;
        }
        if(sender == _viewVoteView.btn2) {
            index = 1;
        }
        if(sender == _viewVoteView.btn3) {
            index = 2;
        }
        if(sender == _viewVoteView.btn4) {
            index = 3;
        }
        [API vote:(int)[[voteData[index] objectForKey:STATUS_FRAME_DATA_OPTIONS_VIEW_INDEX] integerValue]];
        
    }
}

-(BOOL)isiPhone4 {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height <= 480.0f) {
            return YES;
        }
    }
    return NO;
}

-(float)getFontSizeForDevice:(float)size {
    if(![Utils isIPhoneDevice]) {
        size *= 2;
    }
    return size;
}


@end

