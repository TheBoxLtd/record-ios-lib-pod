//
//  API.h
//  webTest
//
//  Created by Jano A. on 21/01/14.
//  Copyright (c) 2014 Jano A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface API : NSObject
@property(strong, nonatomic) NSTimer *connectivityCheckTimer;
@property(strong, nonatomic) NSString *statusFileURL;
@property(strong, nonatomic) NSString *dataFileURL;
@property(strong, nonatomic) NSString *configFileURL;
@property(nonatomic) long lastID;
@property(nonatomic) long lastStatus;
@property(nonatomic) long lastShowID;
@property(nonatomic) long lastVoteID;
@property(nonatomic) int errorCount;
@property(nonatomic) BOOL duet;
@property (strong, nonatomic) NSString *staticPageType;
@property (strong, nonatomic) NSDictionary *staticPageAssets;
@property (strong, nonatomic) NSDictionary *preCache;
@property (strong, nonatomic) NSDictionary *statusData;
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSDictionary *dataGlossary;
@property (strong, nonatomic) NSDictionary *dataGeneral;
@property (strong, nonatomic) NSDictionary *dataVersions;
@property (strong, nonatomic) NSString *waitingText;
@property (nonatomic) BOOL isQAMode;
@property (nonatomic) int dataLoaded;
@property (nonatomic) int signUpIntents;
//@property (nonatomic) BOOL isPicApproved;
@property (nonatomic) BOOL isOffline;
@property (strong, nonatomic) NSString *songName;
@property (nonatomic) float savedInterval;
@property (nonatomic) float savedTimeout;
@property (nonatomic, assign) BOOL isComingFromBg;
@property (nonatomic, assign) BOOL shouldCheckNetwork;

-(void)start;
-(void)stop;
-(void)loadStartData;
-(void)voteSelector:(NSNumber*)option;

//Comm with server
+(void)doCheckin;
+(void)vote:(int)vote;
+(void)picApprove:(BOOL)option;
+(void)doLogIn;
+(void)sendAnalyticsWithScreenName:(NSString*)screen action:(NSString*)action label:(NSString*)label;

//Checks
+(BOOL)isAgeGateActivated;
+(BOOL)isSocialSessionOpen;
+(BOOL)isLoggedIn;
+(BOOL)isPicApproved;
+(BOOL)isDuet;
+(BOOL)isVoted;
+(BOOL)isRegistered;
+(BOOL)isNetworkReachable;
+(BOOL)isTokenExpired;

//Setters
+(void)setRegistered:(BOOL)registered;
+(void)setVoted:(int)option;
+(void)setDuet:(BOOL)option;
+(void)setTestBaseURL:(NSString*)url;
+(void)setTestRegisterURL:(NSString*)url;
+(void)setTestVoteURL:(NSString*)url;
+(void)setTestCheckInURL:(NSString*)url;
+(void)setPicApproved:(BOOL)approved withParentMail:(NSString*)mail;
+(void)setSelectedSocialNetwork:(NSString*)socialNetwork;
+(void)removeTestURLs;
+(void)setQAMode:(BOOL)option;

//Getters
+(float)getTimeout;
+(float)getInterval;
+(long)getLastStatus;
+(int)getVoteOption;
+(UIImage*)getUIImageFromURL:(NSString*)url;
+(NSString*)getBannerURL;
+(NSArray*)getCreatorsURL;
+(NSString*)getDeviceName;
+(NSString*)getGooglePlusID;
+(NSString*)getFacebookID;
+(NSString*)getFacebookDisplayName;
+(NSString*)getVKID;
+(NSString*)getTwitterKey;
+(NSString*)getTwitterSecret;
+(NSString*)getTid;
+(NSArray*)getSocialNetworks;
+(NSString*)getForbiddenText;
+(UIColor*)getThemeColor;
+(NSString*)getParentMail;
+(NSString*)getUserID;
+(NSString*)getUDID;
+(NSString*)getAuthToken;
+(NSString*)getSelectedSocialNetwork;
+(NSArray*)getMediaForGallery;
+(NSDictionary*)getTerritory;
+(NSDictionary*)getDictionary;
+(UIViewController*)getAlertVCForTypeReceived;

//+(void)removeCache;

+(API*)sharedInstance;


@end
