//
//  API.m
//  webTest
//
//  Created by Jano A. on 21/01/14.
//  Copyright (c) 2014 Jano A. All rights reserved.
//

#import "API.h"
#import "AFHTTPRequestOperation.h"
#import <Security/Security.h>
#import "SSKeychain.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "Utils.h"
#import "ConnectionManager.h"
#import "Logger.h"
#import "Constants.h"

@implementation API {
    BOOL isConnectionAlertShown;
    BOOL isConnectionAlertActivated;
}

#pragma mark - external methods
-(void)start {
    _signUpIntents = 0;
    _errorCount = 0;
    _connectivityCheckTimer = [NSTimer scheduledTimerWithTimeInterval:[API getInterval] target:self selector:@selector(checkNetwork) userInfo:nil repeats:YES];
    [self requestStatusFile];
//    isConnectionAlertActivated = [[[Utils getPlistDictionaryWithName:PLIST_LOCALIZED] objectForKey:@"ConnectionAlert"] boolValue];
}

-(void)stop {
    [_connectivityCheckTimer invalidate];
}

-(void)loadStartData {
    _dataLoaded = 0;
    _signUpIntents = 0;
    _errorCount = 0;
//    if(![API isNetworkReachable]) {
//        if(_isOffline) { //Init on offline mode and
//            _dataLoaded = 3;
//            [self initialDataLoaded];
//            [[ConnectionManager sharedInstance] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//                if(status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN) {
//                    if(_isOffline) {
//                        _isOffline = NO;
//                        [self loadStartData];
//                    }
//                }
//            }];
//        }
//        else { //Try again
//            [self performSelector:@selector(loadStartData) withObject:self afterDelay:[API getInterval]];
//            _isOffline = YES;
//            return;
//        }
//    }
//    else {
//        _isOffline = NO;
//        [self checkIfIPIsForbidden];
//    }
    
    
    [self loadData];
    
    _lastShowID = 0;
}

-(void)voteSelector:(NSNumber *)option {
    [API vote:(int)[option integerValue]];
}

#pragma mark - internal methods

-(void)requestStatusFile {
    bool isFirstRequest = NO;
    if(!_statusFileURL) {
        _statusFileURL = [self getStatusFileURL];
        isFirstRequest = YES;
    }
    if(_errorCount > MAX_CONNECTION_INTENTS) {
        [self showConnectionAlert:YES];
        _errorCount = 0;
    }
    
    //NSURLRequestReloadIgnoringLocalCacheData
    //NSURLRequestUseProtocolCachePolicy
    //[[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_STATUS_LAST_MODIFIED_DATE]
    [[ConnectionManager sharedInstance] requestPolling:CONNECTION_TYPE_GET url:_statusFileURL parameters:nil forceFirstResponse:isFirstRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        LOG(@"Request: %@ \n Response: %@",[operation response] , responseObject);
        _errorCount = 0;
        [self showConnectionAlert:NO];
        
        [self processResponse:responseObject fromOperation:operation];
        [self performSelector:@selector(requestStatusFile) withObject:nil afterDelay:[API getInterval]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //LOG(@"Status File Error, count: %d", _errorCount);
        LOG(@"RESPONSE ERROR: %@ \n %@", _statusFileURL, [error userInfo]);
        _errorCount++;
        [self performSelector:@selector(requestStatusFile) withObject:nil afterDelay:[API getInterval]];
    }];
}

-(void)checkIfIPIsForbidden {
    [[ConnectionManager sharedInstance] request:CONNECTION_TYPE_GET url:[self getDataFileURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        LOG(@"IP Not Forbidden: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LOG(@"IP Forbidden Error: %@", [[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding]);
//        NSString *errorCodeForbidden = [[SyncManager sharedInstance] getIDForKey:SYNC_KEY_FORBIDDEN_ERROR_CODE];
//        NSString *errorCodeForbidden = [[Utils getPlistDictionaryWithName:PLIST_LOCALIZED] objectForKey:@"ForbiddenErrorCode"];
//        if([[operation response] statusCode] == [errorCodeForbidden integerValue]) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_IP_IS_FORBIDDEN object:nil userInfo:nil];
//        }
    }];
}

-(void)processResponse:(id)response fromOperation:(AFHTTPRequestOperation*)operation {
    if([response objectForKey:STATUS_FRAME] == [NSNull null]){
        return;
    }
    NSDictionary *frame = [response objectForKey:STATUS_FRAME];

    long newID = [Utils longFromId:[frame objectForKey:STATUS_ID]];
    long status = [Utils longFromId:[frame objectForKey:STATUS_FRAME_STATUS]];
    if (_lastID >= newID && !_isComingFromBg && _lastStatus == status) {
        return;
    }
    LOG(@"JSON: %@", response);
    
    //Store last modified date
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    //NSString *lastModified = [[[operation response] allHeaderFields] objectForKey:@"Last-Modified"];
    NSString *lastModified = [[[operation response] allHeaderFields] objectForKey:@"Date"];
    [standardUserDefaults setObject:lastModified forKey:USER_DEFAULTS_STATUS_LAST_MODIFIED_DATE];
    
    //Get interval and timeout values
    float newInterval = [[response objectForKey:STATUS_INTERVAL] floatValue];
    if (_savedInterval == 0 || _savedInterval != newInterval) {
        _savedInterval = newInterval;
    }
    _savedTimeout = [[response objectForKey:STATUS_TIMEOUT] floatValue];
    
    //Get status url
    NSString *newStatusURL = [response objectForKey:STATUS_URL];
    if(newStatusURL && ![newStatusURL isEqualToString:@""]) {
        self.statusFileURL = newStatusURL;
    }
    
    long showID = [Utils longFromId:[frame objectForKey:STATUS_FRAME_SID]];
    long voteID = 0;
    if(status != 11) {//Only when the page is not static
        if(frame != nil) {
            voteID = [Utils longFromId:[frame objectForKey:@"fid"]];
        }
    }
    if(status == 11) {//Static page
        if([frame isKindOfClass:[NSString class]]) {
            NSData *rawData = [(NSString*)frame dataUsingEncoding:NSUTF8StringEncoding];
            frame = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
        }
        NSString* newStaticType = [frame objectForKey:@"type"];
        
        if(newStaticType != nil && ![_staticPageType isEqualToString:newStaticType]) {
            _staticPageType = newStaticType;
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_STATIC_TYPE_CHANGED object:nil userInfo:[NSDictionary dictionaryWithObject:_staticPageType forKey:NOTIFICATION_STATIC_TYPE_CHANGED]];
        }
        _staticPageAssets = frame;
    }
    
    id updateTime = [response objectForKey:STATUS_SECRET_KEY_UPDATE_TIME];
    if(updateTime && updateTime != [NSNull null]) {
        [self checkSecretKeyUpdateTime:[Utils longFromId:updateTime]];
    }
    
    BOOL newVote = NO;
    if(voteID != _lastVoteID) {
        _lastVoteID = voteID;
        newVote = YES;
    }
    
    _statusData = response;
    if((_lastStatus == 0 || _lastStatus != status) || newVote || _isComingFromBg){
        _isComingFromBg = NO;
        _lastStatus = (int)status;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_STATUS_CHANGED object:nil userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithLong:_lastStatus] forKey:NOTIFICATION_STATUS_CHANGED]];
        LOG(@"New Status: %d",(int)_lastStatus);
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_REFRESH_CONTENT object:nil userInfo:nil];
    }
    
    
    if(showID != _lastShowID) {
//        if(![_lastShowID isEqualToString:@""]) {
//            [self loadPreCacheData];
//        }
        _lastShowID = showID;
    }
    _lastID = newID;
    //[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_REFRESH_CONTENT object:nil userInfo:nil];
    
}

-(NSString*)getBaseDataURL {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults synchronize];
    NSString *testURL = [standardUserDefaults stringForKey:USER_DEFAULTS_TEST_BASE_URL];
    if(testURL != nil && ![testURL isEqualToString:@""]){
        return testURL;
    }
    else {
        NSString *configURL = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_CONFIG_BASE_URL];
        NSString *configTID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_CONFIG_TID];
        if(configURL != nil && ![configURL isEqualToString:@""] && configTID != nil && ![configTID isEqualToString:@""] ){
            return [configURL stringByAppendingString:configTID];
        }
        
        NSString *url = [[Utils getPlistDictionaryWithName:PLIST_CONFIG] objectForKey:@"BaseDataURL"];
        return url;
    }
}

-(NSString*)getStatusFileURL {
    NSString *url = [self getBaseDataURL];
    NSString *statusJSON;
    if(_isQAMode) {
        statusJSON = [[Utils getPlistDictionaryWithName:PLIST_CONFIG] objectForKey:@"StatusQA"];
    }
    else {
        statusJSON = [[Utils getPlistDictionaryWithName:PLIST_CONFIG] objectForKey:@"Status"];
    }
    return [NSString stringWithFormat:@"%@/%@",url,statusJSON];
}

-(NSString*)getDataFileURL {
    NSString *url = [self getBaseDataURL];
    NSString *dataJSON;
    dataJSON = [[Utils getPlistDictionaryWithName:PLIST_CONFIG] objectForKey:@"Data"];
    return [NSString stringWithFormat:@"%@/%@?mode=%@",url,dataJSON, [self getAppMode]];
}

-(NSString*)getVoteURL {
    NSString *url = [self getBaseDataURL];
    NSString *vote = [[Utils getPlistDictionaryWithName:PLIST_CONFIG] objectForKey:@"Vote"];
    return [NSString stringWithFormat:@"%@/%@",url,vote];
}

-(NSString*)getLoginURL {
    NSString *url = [self getBaseDataURL];
    NSString *login = [[Utils getPlistDictionaryWithName:PLIST_CONFIG] objectForKey:@"Login"];
    return [NSString stringWithFormat:@"%@/%@",url,login];
}

-(NSString*)getRegisterURL {
    NSString *url = [self getBaseDataURL];
    NSString *reg = [[Utils getPlistDictionaryWithName:PLIST_CONFIG] objectForKey:@"Register"];
    return [NSString stringWithFormat:@"%@/%@",url,reg];
}

-(NSString*)getCheckInURL {
    NSString *url = [self getBaseDataURL];
    NSString *checkin = [[Utils getPlistDictionaryWithName:PLIST_CONFIG] objectForKey:@"Checkin"];
    return [NSString stringWithFormat:@"%@/%@",url,checkin];
}

-(NSString*)getPreCacheURL {
    NSString *url = [self getBaseDataURL];
    NSString *precache = [[Utils getPlistDictionaryWithName:PLIST_CONFIG] objectForKey:@"Precache"];
    return [NSString stringWithFormat:@"%@/%@",url,precache];
}

-(NSString*)getAppMode {
    if(_isQAMode){
        return @"qa";
    }
    return @"production";
}

-(void)loadPreCacheData {
    [[ConnectionManager sharedInstance] request:CONNECTION_TYPE_GET url:[self getPreCacheURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _preCache = responseObject;
        [self downloadImagesFromPrecache];
        [self initialDataLoaded];
        LOG(@"PRECACHE: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LOG(@"PRECACHE ERROR: %@", [[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding]);
        [self performSelector:@selector(loadPreCacheData) withObject:self afterDelay:[API getInterval]];
    }];
}

-(void)loadData {
    if(!_dataFileURL) {
        _dataFileURL = [self getDataFileURL];
    }
    [[ConnectionManager sharedInstance] request:CONNECTION_TYPE_GET url:_dataFileURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *auxDic = [responseObject objectForKey:DATA_KEY];
        _data = responseObject;
        _dataGeneral = [auxDic objectForKey:DATA_KEY_GENERAL];
        _dataGlossary = [auxDic objectForKey:DATA_KEY_GLOSSARY];
        _dataVersions = [auxDic objectForKey:DATA_KEY_VERSION];
        [self initialDataLoaded];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LOG(@"Data File Error, count: %d", _errorCount);
        [self performSelector:@selector(loadData) withObject:self afterDelay:[API getInterval]];
        _errorCount++;
    }];
}

-(void)initialDataLoaded {
    _dataLoaded++;
    if(_dataLoaded == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DATA_LOADED object:nil];
    }
}

-(void)downloadImagesFromPrecache {
    NSArray *mediaImages = [_preCache objectForKey:@"media"];
    for (NSDictionary *obj in mediaImages) {
        NSString *url;
        if ([Utils isIPhoneDevice]) {
            url = [obj objectForKey:@"medium"];
        }
        else {
            url = [obj objectForKey:@"large"];
        }
        [[ConnectionManager sharedInstance] downloadImageFromURL:url withImageResult:^(UIImage *image) {
            NSString *name = [Utils getImageNameFromURL:url];
            [Utils saveImage:image withName:name];
        } error:^(NSString *error) {
            LOG(@"Image Error: %@", error);
        }];
    }
}

-(void)checkNetwork {
    if(![API isNetworkReachable]) {
        if(!_isOffline) {
            _isOffline = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NETWORK_NOT_REACHABLE object:nil];
        }
    }
    else {
        if(_isOffline) {
            _isOffline = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NETWORK_IS_REACHABLE_AGAIN object:nil];
        }
    }
}

-(void)checkSecretKeyUpdateTime:(long long)updateTime {
//    long long lastTime = [[[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_LAST_LOGIN_TIME] longLongValue];
//    if(lastTime != 0 && updateTime > lastTime) {
//        NSString *socialNetwork = [API getSelectedSocialNetwork];
//        if(socialNetwork != nil) {
//            [[LoginHandler sharedInstance] doLoginWithSocialNetwork:socialNetwork andData:nil];
//        }
//        else {
//            [[LoginHandler sharedInstance] doLoginWithAnonymous];
//        }
//    }
}

-(NSString*)getConnectionErrorText {
    NSString* result = [[self data] objectForKey:DATA_KEY_GLOSSARY_ENTRY_TEXT_CONNECTIVITY_ERROR];
    if(!result) {
        NSString *shellPath = [[NSBundle mainBundle] pathForResource:@"shellData" ofType:@"json"];
        NSString *shellString = [[NSString alloc] initWithContentsOfFile:shellPath encoding:NSUTF8StringEncoding error:nil];
        NSDictionary *shell = [NSJSONSerialization JSONObjectWithData:[shellString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        result = [shell objectForKey:@"connection_alert_text"];
    }
    return result;
}

-(void)showConnectionAlertSelector {
    [self showConnectionAlert:YES];
}

-(void)showConnectionAlert:(BOOL)option {
    if(option == isConnectionAlertShown) {
        return;
    }
    isConnectionAlertShown = option;
    
    if(option){
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHOW_ERROR object:nil userInfo:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_HIDE_ERROR object:nil userInfo:nil];
    }
//    if(option == isConnectionAlertShown || !isConnectionAlertActivated) {
//        return;
//    }
//    isConnectionAlertShown = option;
//    if(option){
//        float dismissTime = [[[self territory] objectForKey:TERRITORY_GENERAL_ERRORMESSAGE_TTL] floatValue];
//        
//        NSDictionary *options = @{kCRToastTextKey : [self getConnectionErrorText],
//                                  kCRToastInteractionRespondersKey : @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
//                                                                                                                       automaticallyDismiss:YES
//                                                                                                                                      block:^(CRToastInteractionType interactionType){
//                                                                                                                                          isConnectionAlertShown = NO;
//                                                                                                                                          [self performSelector:@selector(showConnectionAlertSelector) withObject:self afterDelay:dismissTime];
//                                                                                                                                          _errorCount = 0;
//                                                                                                                                      }]],
////                                  kCRToastImageKey : [Utils loadImageWithName:SYNC_KEY_MEDIA_ALERT_ICON andExtension:IMAGE_EXTENSION_PNG]};
//                                  kCRToastImageKey : [UIImage imageNamed:@"alert_icon.png"]};
//        
//        [CRToastManager showNotificationWithOptions:options completionBlock:^{
//            
//        }];
//        
//    }
//    else {
//        [CRToastManager dismissNotification:YES];
//    }
}

#pragma mark - comms with server

+(void)doCheckin {
//    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[API getUserID], POST_KEY_UID, nil];
//    NSArray *voteIDs = [[[API sharedInstance].statusData objectForKey:STATUS_FRAME] objectForKey:STATUS_FRAME_VOTES];
//    if(voteIDs == nil) {
//        return;
//    }
//    [data setObject:[voteIDs[0] objectForKey:STATUS_FRAME_VOTES_VID] forKey:POST_KEY_VOTEID];
//    if ([voteIDs count] == 2) {
//        [data setObject:[voteIDs[1] objectForKey:STATUS_FRAME_VOTES_VID] forKey:POST_KEY_VOTEID_2];
//    }
//    [data setObject:[API getAuthToken] forKey:POST_KEY_TOKEN];
//    
//    NSString *url = [[[API sharedInstance] getCheckInURL] stringByAppendingString:[Utils queryWithDictionary:data]];
//    
//    [[ConnectionManager sharedInstance] request:CONNECTION_TYPE_GET url:url parameters:nil lastModified:nil customSerializer:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        LOG(@"Registered: Response: %@ %@",[operation responseString],[operation response]);
//        [API setRegistered:YES];
//        [API sendAnalyticsWithScreenName:[Utils formatStringForVoteGA:ANALYTICS_SCREEN_NAME_CHECKIN_SUCCESS] action:ANALYTICS_ACTION_OPEN_SCREEN label:[API getUserID]];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [API setRegistered:YES];
//        LOG(@"REGISTER ERROR: %@",[[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding]);
//    }];
}

+(void)vote:(int)vote {
    if([API isTokenExpired]) {
        [API doLogIn];
        [[API sharedInstance] performSelector:@selector(voteSelector:) withObject:[NSNumber numberWithInt:vote] afterDelay:3];
        return;
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [data setObject:[NSString stringWithFormat:@"%ld",[API sharedInstance].lastVoteID] forKey:POST_KEY_VOTEID];
    //[data setObject:[API getUserID] forKey:POST_KEY_UID];
    [data setObject:[NSString stringWithFormat:@"%d",vote] forKey:POST_KEY_VOTE];
    //[data setObject:[API getAuthToken] forKey:POST_KEY_TOKEN];
    [data setObject:[API sharedInstance].isQAMode ? @"qa" : @"production" forKey:POST_KEY_TYPE];
    
    LOG(@"DATA: %@",data);
    
    NSString* signature = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_SIGNATURE];
    
//    NSString *url = [[[API sharedInstance] getVoteURL] stringByAppendingString:[Utils queryWithDictionary:data]];
    [[ConnectionManager sharedInstance] requestSecure:CONNECTION_TYPE_POST url:[[API sharedInstance] getVoteURL] parameters:data signature:signature success:^(AFHTTPRequestOperation *operation, id responseObject) {
        LOG(@"Voted: Response: %@ %@",[operation responseString] ,[operation response]);
        [API setRegistered:YES];
        //        if([voteValue isEqualToString:@"1"]){
        //            [API sendAnalyticsWithScreenName:[Utils formatStringForVoteGA:ANALYTICS_SCREEN_NAME_VOTE_YES] action:ANALYTICS_ACTION_OPEN_SCREEN label:[API getUserID]];
        //        }
        //        else {
        //            [API sendAnalyticsWithScreenName:[Utils formatStringForVoteGA:ANALYTICS_SCREEN_NAME_VOTE_NO] action:ANALYTICS_ACTION_OPEN_SCREEN label:[API getUserID]];
        //        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[API setRegistered:NO];
        LOG(@"ERROR VOTING: %@, %@",[[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding],error);
    }];
    
    [API setVoted:vote];
}

+(void)picApprove:(BOOL)option {
    //Register User
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    NSString *socialNetwork = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_SOCIAL_NETWORK];
    NSString *appID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_APPID];
    NSString *socialID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_UID];
    [data setObject:@"rs" forKey:@"module"];
    [data setObject:socialNetwork forKey:@"socialNetwork"];
    [data setObject:socialID forKey:@"socialId"];
    [data setObject:appID ? appID : @"" forKey:@"appid"];
    [data setObject:[[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_TOKEN] forKey:@"socialToken"];
    [data setObject:@"ios" forKey:@"devicePlatform"];
    [data setObject:[API getDeviceName] forKey:@"deviceType"];
    [data setObject:option?@"1":@"0" forKey:@"picApproved"];
    
    NSString *url = [[API sharedInstance] getRegisterURL];//@"http://requestb.in/ql24r5ql";
    LOG(@"Pic Approval Request: %@",url);
    [[ConnectionManager sharedInstance] request:CONNECTION_TYPE_POST url:url parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([responseObject objectForKey:@"ERROR"] != [NSNull null]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_ERROR object:nil];
            LOG(@"Pic Approval Error: %@, %@",[[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding], [responseObject objectForKey:@"ERROR"]);
        }
        else {
            LOG(@"Pic Approval Response: %@ %@",[operation responseString] ,[operation response]);
            NSDictionary* respData = [responseObject objectForKey:@"DATA"];
            NSString *user = [respData objectForKey:@"login"];
            NSString *data = [NSString stringWithFormat:@"%@",[respData objectForKey:@"password"]];
            NSString *salt = [respData objectForKey:@"salt"];
            [[NSUserDefaults standardUserDefaults] setObject:user forKey:USER_DEFAULTS_USERNAME];
            [[NSUserDefaults standardUserDefaults] setObject:[Utils hashString:data withSalt:salt] forKey:USER_DEFAULTS_PASSWORD];
            LOG(@"Credentials received: %@ \n %@ \n %@",user, data, salt);
            [API setPicApproved:option withParentMail:nil];
            [API doLogIn];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_DONE object:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LOG(@"Pic Approval Error: %@, %@",[[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding],error);
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_ERROR object:nil];
    }];

}

+(void)doLogIn {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    NSString *user = [standardUserDefaults objectForKey:USER_DEFAULTS_USERNAME];
    NSString *pass = [standardUserDefaults objectForKey:USER_DEFAULTS_PASSWORD];
    [data setObject:user forKey:@"login"];
    [data setObject:pass forKey:@"password"];
    
    NSString *url = [[API sharedInstance] getLoginURL];
    
    [[ConnectionManager sharedInstance] request:CONNECTION_TYPE_POST url:url parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        LOG(@"Request: %@ \n Response: %@",[operation response] , responseObject);
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *responseData = [responseObject objectForKey:@"DATA"];
            NSString *signature = [responseData objectForKey:@"signature"];
            if(!signature || [signature isEqual:[NSNull null]]) {
                signature = @"";
            }
            long expiration = [Utils longFromId:[responseData objectForKey:@"expiration"]];
            long expirationTime = [[NSDate date] timeIntervalSince1970] * 1000 + expiration;
            [standardUserDefaults setObject:signature forKey:USER_DEFAULTS_SIGNATURE];
            [standardUserDefaults setObject:[NSNumber numberWithLong:expirationTime] forKey:USER_DEFAULTS_EXPIRATION];
            [standardUserDefaults synchronize];
        }
        long long timeNow = [[NSDate date] timeIntervalSince1970];
        //LOG(@"Credentials sent: %@ \n %@",user, pass);
        [standardUserDefaults setObject:[NSNumber numberWithLongLong:timeNow] forKey:USER_DEFAULTS_LAST_LOGIN_TIME];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LOG(@"LOGIN ERROR: %@ \n %@",[[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding], error);
        [API sharedInstance].signUpIntents++;
        if([API sharedInstance].signUpIntents < MAX_SIGNUP_INTENTS) {
            [self performSelector:@selector(doLogIn) withObject:nil afterDelay:[API getInterval]];
        }
        else {
            [API sharedInstance].signUpIntents = 0;
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LOGIN_ERROR object:nil];
        }
        [standardUserDefaults setBool:NO forKey:USER_DEFAULTS_LOGIN];
    }];
    
}

+(void)sendAnalyticsWithScreenName:(NSString*)screen action:(NSString*)action label:(NSString*)label {
//    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
//    [tracker set:kGAIScreenName value:screen];
//    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
//                                                          action:action
//                                                           label:label
//                                                           value:nil] build]];
//    [tracker set:kGAIScreenName value:nil];
}

#pragma mark - checking methods

+(BOOL)isAgeGateActivated {
//    return [[[SyncManager sharedInstance] getIDForKey:SYNC_KEY_AGE_GATE] boolValue];
    return YES;
}

+(BOOL)isSocialSessionOpen {
//    BOOL open = NO;
//    //FACEBOOK
//    if(FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
//        open = YES;
//    }
//    //TWITTER
//    if([TwitterEngine sharedInstance].isLogin){
//        open = YES;
//    }
//    return open;
    return YES;
}

+(BOOL)isLoggedIn {
    return [[NSUserDefaults standardUserDefaults] boolForKey:USER_DEFAULTS_LOGIN];
}

+(BOOL)isPicApproved {
    BOOL picApproved = [[NSUserDefaults standardUserDefaults] boolForKey:USER_DEFAULTS_PICAPPROVED];
    return picApproved;
}

+(BOOL)isDuet {
    return [API sharedInstance].duet;
}

+(BOOL)isVoted {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    long voteID = [Utils longFromId:[standardUserDefaults objectForKey:USER_DEFAULTS_VOTED]];
    BOOL registered = voteID == [API sharedInstance].lastVoteID && voteID != 0;
    return registered;
}

+(BOOL)isRegistered {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    long voteID = [Utils longFromId:[standardUserDefaults objectForKey:USER_DEFAULTS_REGISTERED]];
    long lastVoteID = [API sharedInstance].lastVoteID;
    BOOL registered = voteID == lastVoteID;
    return registered;
}

+(BOOL)isNetworkReachable {
    return [[ConnectionManager sharedInstance] isNetworkReachable];
}

+(BOOL)isTokenExpired {
    long expiration = [Utils longFromId:[[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_EXPIRATION]];
    BOOL expirated = [[NSDate date] timeIntervalSince1970] * 1000 > expiration;
    return expirated;
}

#pragma mark - setters

+(void)setRegistered:(BOOL)registered {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    long voteID = registered ? [API sharedInstance].lastVoteID : -1;
    [standardUserDefaults setObject:[NSNumber numberWithLong:voteID] forKey:USER_DEFAULTS_REGISTERED];
    [standardUserDefaults synchronize];
}

+(void)setVoted:(int)option {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    long voteID = option != -1 ? [API sharedInstance].lastVoteID : -1;
    [standardUserDefaults setObject:[NSNumber numberWithLong:voteID] forKey:USER_DEFAULTS_VOTED];
    [standardUserDefaults setInteger:option forKey:USER_DEFAULTS_VOTE_OPTION];
    [standardUserDefaults synchronize];
}

+(void)setDuet:(BOOL)option {
    [API sharedInstance].duet = option;
}

+(void)setTestBaseURL:(NSString *)url {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:url forKey:USER_DEFAULTS_TEST_BASE_URL];
    [standardUserDefaults synchronize];
}

+(void)setTestRegisterURL:(NSString *)url {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:url forKey:USER_DEFAULTS_TEST_REGISTER_URL];
    [standardUserDefaults synchronize];
}

+(void)setTestVoteURL:(NSString *)url {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:url forKey:USER_DEFAULTS_TEST_VOTE_URL];
    [standardUserDefaults synchronize];
}

+(void)setTestCheckInURL:(NSString *)url {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:url forKey:USER_DEFAULTS_TEST_CHECKIN_URL];
    [standardUserDefaults synchronize];
}

+(void)setPicApproved:(BOOL)approved withParentMail:(NSString *)mail {
    [[NSUserDefaults standardUserDefaults] setBool:approved forKey:USER_DEFAULTS_PICAPPROVED];
    if(mail != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:mail forKey:USER_DEFAULTS_PARENT_MAIL];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)setSelectedSocialNetwork:(NSString *)socialNetwork {
    [[NSUserDefaults standardUserDefaults] setObject:socialNetwork forKey:USER_DEFAULTS_SELECTED_SOCIAL_NETWORK];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)removeTestURLs {
    [API setTestBaseURL:@""];
    [API setTestCheckInURL:@""];
    [API setTestRegisterURL:@""];
    [API setTestVoteURL:@""];
}

+(void)setQAMode:(BOOL)option {
    [API sharedInstance].isQAMode = option;
}

#pragma mark - getters

+(float)getTimeout {
    if([API sharedInstance].savedTimeout != 0) {
        return [API sharedInstance].savedTimeout;
    }
    return REQUEST_TIMEOUT;
}

+(float)getInterval {
    if([API sharedInstance].savedInterval != 0) {
        return [API sharedInstance].savedInterval;
    }
    return TIME_BETWEEN_INTENTS;
}

+(long)getLastStatus {
    return [API sharedInstance].lastStatus;
}

+(int)getVoteOption {
    if([API isVoted]) {
        return (int)[[NSUserDefaults standardUserDefaults] integerForKey:USER_DEFAULTS_VOTE_OPTION];
    }
    return -1;
}

+(UIImage *)getUIImageFromURL:(NSString *)url {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithString:[Utils getImageNameFromURL:url]]];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}

+(NSString*)getBannerURL {
    NSString *bannerURL;
    if([Utils isIPhoneDevice]) {
        bannerURL = [[API sharedInstance].data objectForKey:DATA_KEY_GENERAL_LOWER_BANNER_MOBILE];
    }
    else {
        bannerURL = [[API sharedInstance].data objectForKey:DATA_KEY_GENERAL_LOWER_BANNER_TABLET];
    }
    return bannerURL;
}

+(NSArray *)getCreatorsURL {
    return [NSArray arrayWithObjects:@"http://scrnz.com/", @"http://www.keshetinternational.com/",nil];
}

+(NSString *)getDeviceName {
    size_t size = 100;
    char *hw_machine = malloc(size);
    int name[] = {CTL_HW,HW_MACHINE};
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}

//+(NSString *)getGooglePlusID {
//    return [[SyncManager sharedInstance] getIDForKey:SYNC_KEY_GOOGLE_PLUS_ID];
//}
//
//+(NSString *)getFacebookID {
//    return [[SyncManager sharedInstance] getIDForKey:SYNC_KEY_FACEBOOK_ID];
//}
//
//+(NSString *)getFacebookDisplayName {
//    return [[SyncManager sharedInstance] getIDForKey:SYNC_KEY_FACEBOOK_DISPLAY_NAME];
//}
//
//+(NSString *)getVKID {
//    return [[SyncManager sharedInstance] getIDForKey:SYNC_KEY_VK_ID];
//}
//
//+(NSString *)getTwitterKey {
//    return [[SyncManager sharedInstance] getIDForKey:SYNC_KEY_TWITTER_COSTUMER_KEY];
//}
//
//+(NSString *)getTwitterSecret {
//    return [[SyncManager sharedInstance] getIDForKey:SYNC_KEY_TWITTER_SECRET];
//}
//
//+(NSString *)getTid {
//    return [[SyncManager sharedInstance] getIDForKey:SYNC_KEY_TID];
//}
//
//+(NSArray*)getSocialNetworks {
//    return [[SyncManager sharedInstance] getIDForKey:SYNC_KEY_SOCIAL_NETWORKS];
//}
//
//+(NSString*)getForbiddenText {
//    return [[SyncManager sharedInstance] getIDForKey:SYNC_KEY_FORBIDDEN_ERROR_TEXT];
//}
//
//+(UIColor *)getThemeColor {
//    NSString* color = [[SyncManager sharedInstance] getIDForKey:SYNC_KEY_THEME_COLOR];
//    return [Utils colorFromHexString:color];
//}

+(NSString *)getParentMail {
    NSString* parentMail = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_PARENT_MAIL];
    return parentMail;
}

+(NSString *)getUserID {
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_UID];
    if(!uid){
        uid = @"";
    }
    return uid;
}

+(NSString*)getUDID {
    //NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *password = [SSKeychain passwordForService:[[NSBundle mainBundle] bundleIdentifier] account:@"user"];
    if(password == nil) {
        CFUUIDRef theUUID = CFUUIDCreate(NULL);
        CFStringRef string = CFUUIDCreateString(NULL, theUUID);
        CFRelease(theUUID);
        password = (__bridge NSString *)string;
        [SSKeychain setPassword:password forService:[[NSBundle mainBundle] bundleIdentifier] account:@"user"];
    }
    return password;
}

+(NSString *)getAuthToken {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_TOKEN];
    if(!token)
        token = @"";
    return token;
}

+(NSString *)getSelectedSocialNetwork {
    NSString* socialNetwork = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_SELECTED_SOCIAL_NETWORK];
    return socialNetwork;
}

//+(UIViewController*) getAlertVCForTypeReceived {
//    //String for google analytics
//    NSDictionary *frame = [[API sharedInstance].statusData objectForKey:STATUS_FRAME];
//    NSString *sidString = [frame objectForKey:STATUS_FRAME_SID];
//    NSString *tempTypeString = [[frame objectForKey:STATUS_FRAME_DATA] objectForKey:STATUS_FRAME_DATA_TEMP_TYPE];
//    NSString *fidString = [frame objectForKey:STATUS_FRAME_FID];
//    NSString *screenString = [NSString stringWithFormat:@"%@:%@-%@",sidString, tempTypeString, fidString];
//    
//    NSString *type = [API sharedInstance].staticPageType;
//    if([type isEqualToString:STATIC_PAGE_TYPE_NOIMAGE]) {
//        AlertTextViewController *vc = [[AlertTextViewController alloc]initWithNibName:@"AlertTextViewController" bundle:nil];
//        [API sendAnalyticsWithScreenName:screenString action:ANALYTICS_ACTION_OPEN_SCREEN label:[API getUserID]];
//        return vc;
//    }
//    if([type isEqualToString:STATIC_PAGE_TYPE_IMAGE]) {
//        AlertImageViewController *vc = [[AlertImageViewController alloc]initWithNibName:@"AlertImageViewController" bundle:nil];
//        [API sendAnalyticsWithScreenName:screenString action:ANALYTICS_ACTION_OPEN_SCREEN label:[API getUserID]];
//        return vc;
//    }
//    if([type isEqualToString:STATIC_PAGE_TYPE_FULLIMAGE]) {
//        AlertFullImageViewController *vc = [[AlertFullImageViewController alloc]initWithNibName:@"AlertFullImageViewController" bundle:nil];
//        [API sendAnalyticsWithScreenName:screenString action:ANALYTICS_ACTION_OPEN_SCREEN label:[API getUserID]];
//        return vc;
//    }
//    if([type isEqualToString:STATIC_PAGE_TYPE_QUOTE]) {
//        AlertQuoteViewController *vc = [[AlertQuoteViewController alloc]initWithNibName:@"AlertQuoteViewController" bundle:nil];
//        [API sendAnalyticsWithScreenName:screenString action:ANALYTICS_ACTION_OPEN_SCREEN label:[API getUserID]];
//        return vc;
//    }
//    if([type isEqualToString:STATIC_PAGE_TYPE_SCORES]) {
//        FinalViewController *vc = [[FinalViewController alloc]initWithNibName:@"FinalViewController" bundle:nil];
//        return vc;
//    }
//    if([type isEqualToString:STATIC_PAGE_TYPE_WEB]) {
//        AlertWebViewController *vc = [[AlertWebViewController alloc]initWithNibName:@"AlertWebViewController" bundle:nil];
//        //        [API sendAnalyticsWithScreenName:screenString action:ANALYTICS_ACTION_OPEN_SCREEN label:[API getUserID]];
//        return vc;
//    }
//    
//    //Default case
//    AlertTextViewController *vc = [[AlertTextViewController alloc]initWithNibName:@"AlertTextViewController" bundle:nil];
//    [API sendAnalyticsWithScreenName:screenString action:ANALYTICS_ACTION_OPEN_SCREEN label:[API getUserID]];
//    return vc;
//}

//+(void)removeCache {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSFileManager *fileMgr = [[NSFileManager alloc] init];
//    NSError *error = nil;
//    NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error];
//    if (error == nil) {
//        for (NSString *path in directoryContents) {
//            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:path];
//            BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
//            if (!removeSuccess) {
//            }
//        }
//    } else {
//    }
//}

static API *apiInstance;
+ (API *)sharedInstance {
    static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^
                  {
                      apiInstance = [[API alloc] init];
                  });
	
	return apiInstance;
}


@end
