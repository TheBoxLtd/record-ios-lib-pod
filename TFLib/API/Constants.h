//
//  Constants.h
//  Rising Star
//
//  Created by Jano A. on 17/07/14.
//  Copyright (c) 2014 Jano A. All rights reserved.
//

//-----------------------------------------------------------//
//----------------- VALUES
//-----------------------------------------------------------//
#pragma mark - values
#define IS_DEBUG NO
#define DEV_MODE_NUMBER @"061085"
#define MAX_CONNECTION_INTENTS 3
#define MAX_SIGNUP_INTENTS 5
#define REQUEST_TIMEOUT 30
#define TIME_BETWEEN_INTENTS 3
#define IMAGE_NAME_LENGTH 19
#define HEADER_LAST_REQUEST_ID @"last-request-id-handled"
#define HEADER_CLIENT_APP_VERSION @"current-client-app-version"
#define IPAD_TITLE_FONT_SIZE 42
#define IPAD_TEXT_FONT_SIZE 30
#define IPAD_BTN_FONT_SIZE 36

//-----------------------------------------------------------//
//----------------- USER DEFAULTS
//-----------------------------------------------------------//
#pragma mark - user defaults
#define USER_DEFAULTS_LOGIN @"loggedIn"
#define USER_DEFAULTS_DUET @"duet"
#define USER_DEFAULTS_REGISTER_DONE @"register_done"
#define USER_DEFAULTS_UID @"uid_value"
#define USER_DEFAULTS_APPID @"appid_value"
#define USER_DEFAULTS_SOCIAL_NETWORK @"social_network_value"
#define USER_DEFAULTS_TEST_BASE_URL @"test_base_url"
#define USER_DEFAULTS_TEST_REGISTER_URL @"test_register_url"
#define USER_DEFAULTS_TEST_VOTE_URL @"test_vote_url"
#define USER_DEFAULTS_TEST_CHECKIN_URL @"test_checkin_url"
#define USER_DEFAULTS_FACEBOOK_DATA @"fb_data"
#define USER_DEFAULTS_TWITTER_DATA @"tw_data"
#define USER_DEFAULTS_GOOGLE_PLUS_DATA @"gp_data"
#define USER_DEFAULTS_VK_DATA @"vk_data"
#define USER_DEFAULTS_OK_DATA @"ok_data"
#define USER_DEFAULTS_REGISTERED @"registered"
#define USER_DEFAULTS_VOTED @"voted"
#define USER_DEFAULTS_VOTE_OPTION @"vote_option"
#define USER_DEFAULTS_TOKEN @"authToken"
#define USER_DEFAULTS_PICAPPROVED @"pic_approved"
#define USER_DEFAULTS_PARENT_MAIL @"parent_mail"
#define USER_DEFAULTS_SELECTED_SOCIAL_NETWORK @"social_network"
#define USER_DEFAULTS_STATUS_LAST_MODIFIED_DATE @"last_modified_status"
#define USER_DEFAULTS_LAST_LOGIN_TIME @"last_login_time"
#define USER_DEFAULTS_VOTE_OPTION @"vote_option"
#define USER_DEFAULTS_SYNC_DATA @"sync_data"
#define USER_DEFAULTS_SYNC_CACHE_DATA @"sync_cache_data"
#define USER_DEFAULTS_CONFIG_BASE_URL @"config_base"
#define USER_DEFAULTS_CONFIG_LOGIN_URL @"config_login"
#define USER_DEFAULTS_CONFIG_VOTE_URL @"config_vote"
#define USER_DEFAULTS_CONFIG_TID @"config_tid"
#define USER_DEFAULTS_CONFIG_VERSION @"config_version"
#define USER_DEFAULTS_USERNAME @"login"
#define USER_DEFAULTS_PASSWORD @"password"
#define USER_DEFAULTS_SIGNATURE @"signature"
#define USER_DEFAULTS_EXPIRATION @"expiration"


//-----------------------------------------------------------//
//----------------- PLIST
//-----------------------------------------------------------//
#pragma mark - plist
#define PLIST_CONFIG @"Config"


//-----------------------------------------------------------//
//----------------- NOTIFICATION
//-----------------------------------------------------------//
#pragma mark - notification
#define NOTIFICATION_REFRESH_CONTENT @"id_changed"
#define NOTIFICATION_STATUS_CHANGED @"status_changed"
#define NOTIFICATION_STATIC_TYPE_CHANGED @"static_type_changed"
#define NOTIFICATION_DATA_LOADED @"data_loaded"
#define NOTIFICATION_LOGIN_DONE @"login_done"
#define NOTIFICATION_LOGIN_ERROR @"login_error"
#define NOTIFICATION_IMAGE_DOWNLOADED @"image_downloaded"
#define NOTIFICATION_IMAGE_DOWNLOAD_ERROR @"image_download_error"
#define NOTIFICATION_NETWORK_IS_REACHABLE_AGAIN @"network_is_reachable"
#define NOTIFICATION_NETWORK_NOT_REACHABLE @"network_is_not_reachable"
#define NOTIFICATION_IP_IS_FORBIDDEN @"ip_forbidden"
#define NOTIFICATION_SHOW_ERROR @"show_error"
#define NOTIFICATION_HIDE_ERROR @"hide_error"


//-----------------------------------------------------------//
//----------------- POST
//-----------------------------------------------------------//
#pragma mark - post
#define POST_KEY_VOTEID @"vid"
#define POST_KEY_VOTEID_1 @"voteId1"
#define POST_KEY_VOTEID_2 @"voteId2"
#define POST_KEY_UID @"u"
#define POST_KEY_VOTE @"opt"
#define POST_KEY_TYPE @"type"
#define POST_KEY_TOKEN @"t"
#define POST_LOGIN_KEY_UID @"uid"
#define POST_PIC_KEY_PICAPPROVED @"picApproved"
#define POST_PIC_KEY_TOKEN @"token"
#define POST_PIC_KEY_UID @"uid"
#define POST_PIC_KEY_TID @"tid"

//-----------------------------------------------------------//
//----------------- CUSTOM FONTS
//-----------------------------------------------------------//
#pragma mark - fonts
#define FONT_MYRIAD_REGULAR @"MyriadPro-Regular"
#define FONT_MYRIAD_BOLD @"MyriadPro-Bold"

//-----------------------------------------------------------//
//----------------- DATA
//-----------------------------------------------------------//
#pragma mark - data
#define DATA_KEY_ERROR @"ERROR"
#define DATA_KEY_V @"V"
#define DATA_KEY @"DATA"
#define DATA_KEY_GENERAL @"general"
#define DATA_KEY_GENERAL_GALLERY_SLIDER_ENABLED @"gallery-slider-enabled"
#define DATA_KEY_GENERAL_GALLERY_SLIDER_VISIBLE @"gallery-slider-visible"
#define DATA_KEY_GENERAL_CONNECTIVITY_ERROR_TTL @"connectivity-error-ttl"
#define DATA_KEY_GENERAL_DOWNLOAD_SONGS_BUTTON_ICON @"download-songs-button-icon"
#define DATA_KEY_GENERAL_DOWNLOAD_SONGS_BUTTON_URL @"download-songs-button-url"
#define DATA_KEY_GENERAL_DOWNLOAD_SONGS_BUTTON_VISIBLE @"download-songs-button-visible"
#define DATA_KEY_GENERAL_BACKGROUND_MOBILE @"background-mobile"
#define DATA_KEY_GENERAL_BACKGROUND_TABLET @"background-tablet"
#define DATA_KEY_GENERAL_FLIP_SCREEN_MOBILE @"flip-screen-mobile"
#define DATA_KEY_GENERAL_FLIP_SCREEN_TABLET @"flip-screen-tablet"
#define DATA_KEY_GENERAL_HEADER_LOGO_MOBILE @"header-logo-mobile"
#define DATA_KEY_GENERAL_HEADER_LOGO_TABLET @"header-logo-tablet"
#define DATA_KEY_GENERAL_SPONSOR_LOGO_MOBILE @"sponsor-logo-mobile"
#define DATA_KEY_GENERAL_SPONSOR_LOGO_TABLET @"sponsor-logo-tablet"
#define DATA_KEY_GENERAL_MAIN_LOGO_MOBILE @"main-logo-mobile"
#define DATA_KEY_GENERAL_MAIN_LOGO_TABLET @"main-logo-tablet"
#define DATA_KEY_GENERAL_LOWER_BANNER_MOBILE @"lower-banner-mobile"
#define DATA_KEY_GENERAL_LOWER_BANNER_TABLET @"lower-banner-tablet"
#define DATA_KEY_GENERAL_FULL_BANNER_MOBILE @"full-banner-mobile"
#define DATA_KEY_GENERAL_FULL_BANNER_TABLET @"full-banner-tablet"
#define DATA_KEY_GENERAL_FULL_BANNER_TTL @"full-banner-ttl"
#define DATA_KEY_GLOSSARY @"glossary"
#define DATA_KEY_GLOSSARY_ENTRY @"entry"
#define DATA_KEY_GLOSSARY_ENTRY_TEXT_SLIDER @"text-slider"
#define DATA_KEY_GLOSSARY_ENTRY_TEXT_LOADING @"text-loading"
#define DATA_KEY_GLOSSARY_ENTRY_TEXT_NO_CONNECTION @"text-no-connection"
#define DATA_KEY_GLOSSARY_ENTRY_TEXT_CONNECTIVITY_ERROR @"text-connectivity-error"
#define DATA_KEY_GLOSSARY_REGISTRATION @"registration"
#define DATA_KEY_GLOSSARY_REGISTRATION_LOGIN_TITLE @"login-title"
#define DATA_KEY_GLOSSARY_REGISTRATION_LOGIN_TOS_1 @"login-tos-1"
#define DATA_KEY_GLOSSARY_REGISTRATION_LOGIN_TOS_2 @"login-tos-2"
#define DATA_KEY_GLOSSARY_REGISTRATION_LOGIN_TOS_3 @"login-tos-3"
#define DATA_KEY_GLOSSARY_REGISTRATION_LOGIN_TOS_ERROR @"login-tos-error"
#define DATA_KEY_GLOSSARY_REGISTRATION_LOGIN_PICAPPROVE_CHECKBOX @"login-picapprove-checkbox"
#define DATA_KEY_GLOSSARY_REGISTRATION_ERRORS_FB_IOS @"errors-fb-ios"
#define DATA_KEY_GLOSSARY_REGISTRATION_ERRORS_T_IOS @"errors-t-ios"
#define DATA_KEY_GLOSSARY_REGISTRATION_ERRORS_G_IOS @"errors-g-ios"
#define DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_TITLE @"picapprove-title"
#define DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_SUBTITLE @"picapprove-subtitle"
#define DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_OVER18 @"picapprove-over18"
#define DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_UNDER18 @"picapprove-under18"
#define DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_NO @"picapprove-no"
#define DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_FORM_TITLE @"picapprove-form-title"
#define DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_FORM_SUBTITLE @"picapprove-form-subtitle"
#define DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_FORM_EMAIL_ERROR @"picapprove-form-email-error"
#define DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_FORM_YES @"picapprove-form-yes"
#define DATA_KEY_GLOSSARY_REGISTRATION_PICAPPROVE_FORM_NO @"picapprove-form-no"
#define DATA_KEY_GLOSSARY_VOTING @"voting"
#define DATA_KEY_GLOSSARY_VOTING_CHECKIN_TITLE @"checkin-title"
#define DATA_KEY_GLOSSARY_VOTING_CHECKIN_BUTTON @"checkin-button"
#define DATA_KEY_GLOSSARY_VOTING_CHECKIN_AFTER @"checkin-after"
#define DATA_KEY_GLOSSARY_VOTING_MISSED_TITLE @"missed-title"
#define DATA_KEY_GLOSSARY_VOTING_MISSED_DISABLED_BUTTON @"missed-disabled-button"
#define DATA_KEY_GLOSSARY_VOTING_MISSED_WAITING_TEXT @"missed-waiting-text"
#define DATA_KEY_GLOSSARY_VOTING_VOTE_TEXT @"vote-text"
#define DATA_KEY_GLOSSARY_VOTING_VOTE_YES @"vote-yes"
#define DATA_KEY_GLOSSARY_VOTING_VOTE_NO @"vote-no"
#define DATA_KEY_GLOSSARY_VOTING_CLOSED_TITLE @"closed-title"
#define DATA_KEY_GLOSSARY_VOTING_CLOSED_WAITING_TEXT @"closed-waiting-text"
#define DATA_KEY_GLOSSARY_VOTING_BEFORE_RESULTS_TITLE @"before-results-title"
#define DATA_KEY_GLOSSARY_VOTING_BEFORE_RESULTS_WAITING_TEXT @"before-results-waiting-text"
#define DATA_KEY_GLOSSARY_VOTING_RESULTS_TEXT @"results-text"
#define DATA_KEY_GLOSSARY_VOTING_FINAL_RESULTS_TEXT @"final-results-text"
#define DATA_KEY_GLOSSARY_VOTING_FINAL_RESULTS_DOWNLOAD_TITLE @"final-results-download-title"
#define DATA_KEY_GLOSSARY_VOTING_FINAL_RESULTS_DOWNLOAD_TEXT @"final-results-download-text"
#define DATA_KEY_GLOSSARY_VOTING_FINAL_RESULTS_PIC_APPROVE @"final-results-pic-approve"
#define DATA_KEY_GLOSSARY_SOCIAL @"social"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_FB_TEXT @"sharing-fb-text"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_FB_NAME @"sharing-fb-name"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_FB_CAPTION @"sharing-fb-caption"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_FB_URL @"sharing-fb-url"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_FB_PIC_LINK @"sharing-fb-pic-link"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_FB_CONFIRM @"sharing-fb-confirm"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_FB_DISMISS @"sharing-fb-dismiss"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_T_TEXT @"sharing-t-text"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_T_URL @"sharing-t-url"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_T_PIC_LINK @"sharing-t-pic-link"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_T_CONFIRM @"sharing-t-confirm"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_T_DISMISS @"sharing-t-dismiss"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_T_VIA @"sharing-t-via"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_T_HASHTAGS @"sharing-t-hashtags"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_T_RELATED @"sharing-t-related"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_G_TITLE @"sharing-g-title"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_G_TEXT @"sharing-g-text"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_G_DESCRIPTION @"sharing-g-description"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_G_CONFIRM @"sharing-g-confirm"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_G_DISMISS @"sharing-g-dismiss"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_G_PIC_LINK @"sharing-g-pic-link"
#define DATA_KEY_GLOSSARY_SOCIAL_SHARING_G_DEEP_LINK @"sharing-g-deep-link"
#define DATA_KEY_GLOSSARY_APPBUTTONS @"appbuttons"
#define DATA_KEY_GLOSSARY_APPBUTTONS_BACK_BUTTON_GALLERY_TITLE @"back-button-gallery-title"
#define DATA_KEY_GLOSSARY_APPBUTTONS_BACK_BUTTON_GALLERY_CONTENT @"back-button-gallery-content"
#define DATA_KEY_GLOSSARY_APPBUTTONS_BACK_BUTTON_GALLERY_CONFIRM @"back-button-gallery-confirm"
#define DATA_KEY_GLOSSARY_APPBUTTONS_BACK_BUTTON_GALLERY_DISMISS @"back-button-gallery-dismiss"
#define DATA_KEY_GLOSSARY_APPBUTTONS_BACK_BUTTON_REG_TITLE @"back-button-reg-title"
#define DATA_KEY_GLOSSARY_APPBUTTONS_BACK_BUTTON_REG_CONTENT @"back-button-reg-content"
#define DATA_KEY_GLOSSARY_APPBUTTONS_BACK_BUTTON_REG_CONFIRM @"back-button-reg-confirm"
#define DATA_KEY_GLOSSARY_APPBUTTONS_BACK_BUTTON_REG_DISMISS @"back-button-reg-dismiss"
#define DATA_KEY_GLOSSARY_APPBUTTONS_BACK_BUTTON_VOTING_TITLE @"back-button-voting-title"
#define DATA_KEY_GLOSSARY_APPBUTTONS_BACK_BUTTON_CONTENT @"back-button-content"
#define DATA_KEY_GLOSSARY_APPBUTTONS_BACK_BUTTON_CONFIRM @"back-button-confirm"
#define DATA_KEY_VERSION @"version"
#define DATA_KEY_VERSION_IOS @"ios"
#define DATA_KEY_VERSION_IOS_NUMBER @"number"
#define DATA_KEY_VERSION_IOS_IS_MANDATORY @"is-mandatory"
#define DATA_KEY_VERSION_IOS_ALERT_TITLE @"alert-title"
#define DATA_KEY_VERSION_IOS_ALERT_TEXT @"alert-text"
#define DATA_KEY_VERSION_IOS_APPSTORE_LINK @"appstore-link"
#define DATA_KEY_VERSION_IOS_BUTTON_POSITIVE_TEXT @"button-positive-text"
#define DATA_KEY_VERSION_IOS_BUTTON_NEGATIVE_TEXT @"button-negative-text"
#define DATA_KEY_GALLERY @"gallery"





//-----------------------------------------------------------//
//----------------- STATUS
//-----------------------------------------------------------//
#pragma mark - status
#define STATUS_ID @"id"
#define STATUS_FRAME @"frame"
#define STATUS_FRAME_FID @"fid"
#define STATUS_FRAME_SID @"sid"
#define STATUS_FRAME_TYPE @"type"
#define STATUS_FRAME_TYPE_VOTE @"vote"
#define STATUS_FRAME_TYPE_IMAGE @"standard"
#define STATUS_FRAME_TYPE_TEXT @"message"
#define STATUS_FRAME_DATA @"data"
#define STATUS_FRAME_DATA_TITLE @"title"
#define STATUS_FRAME_DATA_TEXT @"text"
#define STATUS_FRAME_DATA_QUESTION @"question"
#define STATUS_FRAME_DATA_LARGE @"large"
#define STATUS_FRAME_DATA_MEDIUM @"medium"
#define STATUS_FRAME_DATA_VID @"sid"
#define STATUS_FRAME_DATA_VOTETYPE @"voteType"
#define STATUS_FRAME_DATA_OPTIONS @"options"
#define STATUS_FRAME_DATA_OPTIONS_ID @"id"
#define STATUS_FRAME_DATA_OPTIONS_VIEW_INDEX @"viewIndex"
#define STATUS_FRAME_DATA_OPTIONS_TEXT @"text"
#define STATUS_FRAME_DATA_ALLOWED @"allowed"
#define STATUS_FRAME_STATUS @"status"
#define STATUS_FRAME_ORDER @"order"
#define STATUS_INTERVAL @"interval"
#define STATUS_TIMEOUT @"timeout"
#define STATUS_SECRET_KEY_UPDATE_TIME @"secretKeyUpdateTime"
#define STATUS_URL @"statusURL"


//-----------------------------------------------------------//
//----------------- STATIC
//-----------------------------------------------------------//
#pragma mark - static
#define STATIC_PAGE_TYPE_NOIMAGE @"message"
#define STATIC_PAGE_TYPE_IMAGE @"standard"
#define STATIC_PAGE_TYPE_FULLIMAGE @"fullpage"
#define STATIC_PAGE_TYPE_QUOTE @"quote"
#define STATIC_PAGE_TYPE_SCORES @"score"
#define STATIC_PAGE_TYPE_WEB @"webview"
#define STATIC_PAGE_WAITING_TEXT @"waitingText"
#define STATIC_PAGE_SHOW_WAITING_TEXT @"showWaitingText"
#define STATIC_PAGE_MAIN_TEXT @"mainText"
#define STATIC_PAGE_ARTIST_NAME @"artistName"


//-----------------------------------------------------------//
//----------------- MEDIA
//-----------------------------------------------------------//
#pragma mark - media
#define MEDIA_TYPE @"type"
#define MEDIA_TYPE_IMAGE @"image"
#define MEDIA_TYPE_VIDEO @"video"
#define MEDIA_TYPE_LINK @"link"
#define MEDIA_TYPE_LINK_TO_VOTING @"inapp"
#define MEDIA_URL @"src"
#define MEDIA_THUMB @"thumb"
#define MEDIA_TEXT @"text"


//-----------------------------------------------------------//
//----------------- SHELL
//-----------------------------------------------------------//
#pragma mark - shell
#define SHELL_GALLERY @"gallery"
#define SHELL_SLIDER @"slider"
#define SHELL_SLIDER_TEXT @"text"
#define SHELL_SLIDER_ENABLED @"enabled"
#define SHELL_SLIDER_HIDDEN @"hidden"


//-----------------------------------------------------------//
//----------------- SOCIAL
//-----------------------------------------------------------//
#pragma mark - social
#define FACEBOOK_FIRST_NAME @"first_name"
#define FACEBOOK_GENDER @"gender"
#define SOCIAL_NETWORK_FACEBOOK @"Facebook"
#define SOCIAL_NETWORK_TWITTER @"Twitter"
#define SOCIAL_NETWORK_GOOGLE_PLUS @"Google"
#define SOCIAL_NETWORK_VK @"VK"
#define SOCIAL_NETWORK_OK @"OK"
#define FACEBOOK_ID @"id"
#define FACEBOOK_LAST_NAME @"last_name"
#define FACEBOOK_AGE_RANGE @"age_range"
#define FACEBOOK_BIRTHDAY @"birthday"
#define FACEBOOK_LOCATION @"location"
#define FACEBOOK_RELATIONSHIP @"relationship_status"
#define TWITTER_ID @"id_str"
#define TWITTER_NAME @"name"
#define TWITTER_LOCATION @"location"
#define TWITTER_IMAGE @"profile_image_url"


//-----------------------------------------------------------//
//----------------- LOGIN
//-----------------------------------------------------------//
#pragma mark - login
#define LOGIN_KEY_TID @"tid"
#define LOGIN_KEY_FACEBOOKID @"facebookId"
#define LOGIN_KEY_NAME @"name"
#define LOGIN_KEY_SEX @"sex"
#define LOGIN_KEY_BIRTHDAY @"birthday"
#define LOGIN_KEY_AGE_RANGE @"ageRange"
#define LOGIN_KEY_LOCATION @"location"
#define LOGIN_KEY_RELATIONSHIP @"relationshipStatus"
#define LOGIN_KEY_DEVICE_TYPE @"deviceType"
#define LOGIN_KEY_USERNAME @"username"
#define LOGIN_KEY_UDID @"udid"
#define LOGIN_KEY_PIC_APPROVED @"picApproved"
#define LOGIN_KEY_PARENT_EMAIL @"parentEmail"
#define LOGIN_KEY_SOCIAL_ID @"socialId"
#define LOGIN_KEY_SOCIAL_NETWORK @"socialNetwork"
#define LOGIN_KEY_DEVICE_PLATFORM @"devicePlatform"
#define LOGIN_KEY_SOCIAL_TOKEN @"socialToken"
#define LOGIN_KEY_PICTURE_URL @"picURL"
#define LOGIN_KEY_OLD_AUTH_TOKEN @"old_auth_token"


//-----------------------------------------------------------//
//----------------- ANALYTICS
//-----------------------------------------------------------//
#pragma mark - analytics
#define ANALYTICS_SCREEN_NAME_FINAL_RESULTS @"final_results"
#define ANALYTICS_SCREEN_NAME_CHECKIN @"checkin"
#define ANALYTICS_SCREEN_NAME_CHECKIN_SUCCESS @"checkin_success"
#define ANALYTICS_SCREEN_NAME_MISSED_CHECKIN @"checkin_missed"
#define ANALYTICS_SCREEN_NAME_CHECKIN_ALERT @"checkin_alert"
#define ANALYTICS_SCREEN_NAME_VOTE @"vote"
#define ANALYTICS_SCREEN_NAME_VOTE_YES @"vote_yes"
#define ANALYTICS_SCREEN_NAME_VOTE_NO @"vote_no"
#define ANALYTICS_SCREEN_NAME_VOTE_ALERT @"vote_alert"
#define ANALYTICS_SCREEN_NAME_VOTE_CLOSED @"vote_closed"
#define ANALYTICS_SCREEN_NAME_VOTE_RESULTS @"vote_results"
#define ANALYTICS_SCREEN_NAME_PIC_APPROVE @"picapprove"
#define ANALYTICS_SCREEN_NAME_PIC_CONSENT @"picapprove_consent"
#define ANALYTICS_SCREEN_NAME_LOGIN @"login"
#define ANALYTICS_ACTION_SIGNUP_FB @"signup_fb"
#define ANALYTICS_ACTION_SIGNUP_TW @"signup_tw"
#define ANALYTICS_ACTION_SIGNUP_GP @"signup_gp"
#define ANALYTICS_ACTION_SIGNUP_VK @"signup_vk"
#define ANALYTICS_ACTION_PICAPPROVE_OK @"picapprove_ok"
#define ANALYTICS_ACTION_PICAPPROVE_KID @"picapprove_kid"
#define ANALYTICS_ACTION_PICAPPROVE_KID_OK @"picapprove_kid_ok"
#define ANALYTICS_ACTION_PICAPPROVE_KID_NO @"picapprove_kid_no"
#define ANALYTICS_ACTION_PICAPPROVE_NO @"picapprove_no"
#define ANALYTICS_ACTION_VOTE_SHARE_TW @"vote_share_tw"
#define ANALYTICS_ACTION_VOTE_SHARE_FB @"vote_share_fb"
#define ANALYTICS_ACTION_FINAL_DOWNLOAD @"final_download"
#define ANALYTICS_ACTION_FINAL_PICAPPROVE @"final_pic_approve"
#define ANALYTICS_ACTION_OPEN_SCREEN @"open_screen"



//-----------------------------------------------------------//
//----------------- SYNC
//-----------------------------------------------------------//
#pragma mark - sync

//----------------- LIBRARIES IDs AND KEYS -----------------//
#define SYNC_KEY_TWITTER_COSTUMER_KEY @"twitter.costumer.key"
#define SYNC_KEY_TWITTER_SECRET @"twitter.secret"
#define SYNC_KEY_GOOGLE_PLUS_ID @"google.plus.id"
#define SYNC_KEY_FACEBOOK_ID @"facebook.id"
#define SYNC_KEY_FACEBOOK_DISPLAY_NAME @"facebook.display.name"
#define SYNC_KEY_VK_ID @"vk.id"
#define SYNC_KEY_SOCIAL_NETWORKS @"social.networks"
#define SYNC_KEY_MAT_ADVERTISER_ID @"mat.advertiser.id"
#define SYNC_KEY_MAT_CONVERSION_KEY @"mat.conversion.key"
#define SYNC_KEY_NEW_RELIC_TOKEN @"new.relic.token"
#define SYNC_KEY_APPOXEE_ID @"appoxee.id"
#define SYNC_KEY_APPOXEE_SECRET @"appoxee.secret"
#define SYNC_KEY_GA_TRACKING_ID @"ga.tracking.id"

//----------------- MISC -----------------//
#define SYNC_KEY_AGE_GATE @"age.gate"
#define SYNC_KEY_THEME_COLOR @"theme.color"
#define SYNC_KEY_FORBIDDEN_ERROR_TEXT @"forbidden.error.text"
#define SYNC_KEY_FORBIDDEN_ERROR_CODE @"forbidden.error.code"

//----------------- URLS & JSONs -----------------//
#define SYNC_KEY_JSON_NAME_PRECACHE @"json.name.precache"
#define SYNC_KEY_JSON_NAME_DICTIONARY @"json.name.dictionary"
#define SYNC_KEY_JSON_NAME_TERRITORY @"json.name.territory"
#define SYNC_KEY_JSON_NAME_STATUS @"json.name.status"
#define SYNC_KEY_JSON_NAME_SHELL @"json.name.shell"
#define SYNC_KEY_JSON_NAME_STATUSQA @"json.name.status.qa"
#define SYNC_KEY_JSON_NAME_SHELLQA @"json.name.shell.qa"
#define SYNC_KEY_URL_BASE @"url.base"
#define SYNC_KEY_URL_LOGIN @"url.login"
#define SYNC_KEY_URL_VOTE @"url.vote"
#define SYNC_KEY_URL_CHECKIN @"url.checkin"
#define SYNC_KEY_TID @"tid"
#define SYNC_KEY_OFFLINE_JSON_TERRITORY @"offline.json.territory"
#define SYNC_KEY_OFFLINE_JSON_DICTIONARY @"offline.json.dictionary"
#define SYNC_KEY_OFFLINE_JSON_PRECACHE @"offline.json.precache"
#define SYNC_KEY_OFFLINE_JSON_SHELL @"offline.json.shell"

//----------------- IMAGES -----------------//
#define SYNC_KEY_MEDIA @"media"
#define SYNC_KEY_MEDIA_BUTTONS @"buttons"
#define SYNC_KEY_MEDIA_BUTTONS_EMPTY @"button_empty"
#define SYNC_KEY_MEDIA_BUTTONS_BACK @"button_back"
#define SYNC_KEY_MEDIA_BUTTONS_DOWNLOAD_GENERAL @"button_download_general"
#define SYNC_KEY_MEDIA_BUTTONS_DOWNLOAD_MUSIC @"button_download_music"
#define SYNC_KEY_MEDIA_BUTTONS_DOWNLOAD_NONE @"button_download_none"
#define SYNC_KEY_MEDIA_BUTTONS_DOWNLOAD_VIDEO @"button_download_video"
#define SYNC_KEY_MEDIA_BUTTONS_CHECKBOX_OFF @"checkbox_off"
#define SYNC_KEY_MEDIA_BUTTONS_CHECKBOX_ON @"checkbox_on"
#define SYNC_KEY_MEDIA_BUTTONS_CLOSE @"button_close"
#define SYNC_KEY_MEDIA_BUTTONS_LOGIN_FB @"button_login_fb"
#define SYNC_KEY_MEDIA_BUTTONS_LOGIN_TW @"button_login_tw"
#define SYNC_KEY_MEDIA_BUTTONS_LOGIN_VK @"button_login_vk"
#define SYNC_KEY_MEDIA_BUTTONS_LOGIN_GP @"button_login_gp"
#define SYNC_KEY_MEDIA_BUTTONS_RESULTS_FB @"button_results_fb"
#define SYNC_KEY_MEDIA_BUTTONS_RESULTS_TW @"button_results_tw"
#define SYNC_KEY_MEDIA_BUTTONS_RESULTS_VK @"button_results_vk"
#define SYNC_KEY_MEDIA_BUTTONS_RESULTS_GP @"button_results_gp"
#define SYNC_KEY_MEDIA_BUTTONS_SETTINGS @"button_settings_close"
#define SYNC_KEY_MEDIA_BUTTONS_ALERT_WEB_BACK @"button_alert_web_back"
#define SYNC_KEY_MEDIA_BUTTONS_ALERT_WEB_NEXT @"button_alert_web_next"
#define SYNC_KEY_MEDIA_BUTTONS_ALERT_WEB_REFRESH @"button_alert_web_refresh"
#define SYNC_KEY_MEDIA_BUTTONS_SHARE_FB @"button_share_fb"
#define SYNC_KEY_MEDIA_BUTTONS_SHARE_GP @"button_share_gp"
#define SYNC_KEY_MEDIA_BUTTONS_SHARE_VK @"button_share_vk"
#define SYNC_KEY_MEDIA_BUTTONS_SHARE_TW @"button_share_tw"
#define SYNC_KEY_MEDIA_BUTTONS_WEB_BACK @"button_web_back"
#define SYNC_KEY_MEDIA_BUTTONS_WEB_NEXT @"button_web_next"
#define SYNC_ARRAY_MEDIA_BUTTONS @[SYNC_KEY_MEDIA_BUTTONS_EMPTY,SYNC_KEY_MEDIA_BUTTONS_BACK,SYNC_KEY_MEDIA_BUTTONS_DOWNLOAD_GENERAL,SYNC_KEY_MEDIA_BUTTONS_DOWNLOAD_MUSIC,SYNC_KEY_MEDIA_BUTTONS_DOWNLOAD_NONE,SYNC_KEY_MEDIA_BUTTONS_DOWNLOAD_VIDEO,SYNC_KEY_MEDIA_BUTTONS_CHECKBOX_OFF,SYNC_KEY_MEDIA_BUTTONS_CHECKBOX_ON,SYNC_KEY_MEDIA_BUTTONS_CLOSE,SYNC_KEY_MEDIA_BUTTONS_LOGIN_FB,SYNC_KEY_MEDIA_BUTTONS_LOGIN_TW,SYNC_KEY_MEDIA_BUTTONS_LOGIN_VK,SYNC_KEY_MEDIA_BUTTONS_LOGIN_GP,SYNC_KEY_MEDIA_BUTTONS_RESULTS_FB,SYNC_KEY_MEDIA_BUTTONS_RESULTS_TW,SYNC_KEY_MEDIA_BUTTONS_RESULTS_VK,SYNC_KEY_MEDIA_BUTTONS_RESULTS_GP,SYNC_KEY_MEDIA_BUTTONS_SETTINGS,SYNC_KEY_MEDIA_BUTTONS_ALERT_WEB_BACK,SYNC_KEY_MEDIA_BUTTONS_ALERT_WEB_NEXT,SYNC_KEY_MEDIA_BUTTONS_ALERT_WEB_REFRESH,SYNC_KEY_MEDIA_BUTTONS_SHARE_FB,SYNC_KEY_MEDIA_BUTTONS_SHARE_GP,SYNC_KEY_MEDIA_BUTTONS_SHARE_VK,SYNC_KEY_MEDIA_BUTTONS_SHARE_TW,SYNC_KEY_MEDIA_BUTTONS_WEB_BACK,SYNC_KEY_MEDIA_BUTTONS_WEB_NEXT]
#define SYNC_KEY_MEDIA_CELLS @"cells"
#define SYNC_KEY_MEDIA_CELLS_BG_BOTTOM @"cell_bg_bottom"
#define SYNC_KEY_MEDIA_CELLS_BG_MIDDLE @"cell_bg_middle"
#define SYNC_KEY_MEDIA_CELLS_BG_SINGLE @"cell_bg_single"
#define SYNC_KEY_MEDIA_CELLS_BG_TOP @"cell_bg_top"
#define SYNC_KEY_MEDIA_CELLS_CELL_DIVIDER @"cell_divider"
#define SYNC_ARRAY_MEDIA_CELLS @[SYNC_KEY_MEDIA_CELLS_BG_BOTTOM,SYNC_KEY_MEDIA_CELLS_BG_MIDDLE,SYNC_KEY_MEDIA_CELLS_BG_SINGLE,SYNC_KEY_MEDIA_CELLS_BG_TOP]
#define SYNC_KEY_MEDIA_FRAMES @"frames"
#define SYNC_KEY_MEDIA_FRAMES_FRAME @"frame"
#define SYNC_KEY_MEDIA_FRAMES_QUOTE @"frame_quote"
#define SYNC_KEY_MEDIA_FRAMES_CHECKIN_TOP @"frame_checkin_top"
#define SYNC_KEY_MEDIA_FRAMES_FINAL @"frame_final"
#define SYNC_KEY_MEDIA_FRAMES_ALERT_IMAGE_FRAME @"frame_alert_image"
#define SYNC_KEY_MEDIA_FRAMES_ALERT_TEXT_FRAME @"frame_alert_text"
#define SYNC_ARRAY_MEDIA_FRAMES @[SYNC_KEY_MEDIA_FRAMES_QUOTE,SYNC_KEY_MEDIA_FRAMES_CHECKIN_TOP,SYNC_KEY_MEDIA_FRAMES_FINAL,SYNC_KEY_MEDIA_FRAMES_ALERT_IMAGE_FRAME,SYNC_KEY_MEDIA_FRAMES_ALERT_TEXT_FRAME]
#define SYNC_KEY_MEDIA_SLIDER @"slider"
#define SYNC_KEY_MEDIA_SLIDER_BACKGROUND @"slider_background"
#define SYNC_KEY_MEDIA_SLIDER_BACKGROUND_ALERT @"slider_background_alert"
#define SYNC_KEY_MEDIA_SLIDER_BACKGROUND_DISABLED @"slider_background_disabled"
#define SYNC_KEY_MEDIA_SLIDER_ARROW @"slider_arrow"
#define SYNC_ARRAY_MEDIA_SLIDER @[SYNC_KEY_MEDIA_SLIDER_BACKGROUND,SYNC_KEY_MEDIA_SLIDER_BACKGROUND_ALERT,SYNC_KEY_MEDIA_SLIDER_BACKGROUND_DISABLED,SYNC_KEY_MEDIA_SLIDER_ARROW]
#define SYNC_KEY_MEDIA_VOTE_SLIDER @"vote_slider"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_ALERT_BG_LEFT @"vote_slider_alert_bg_left"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_ALERT_BG_RIGHT @"vote_slider_alert_bg_right"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_YES_LEFT @"vote_slider_arrow_yes_left"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_YES_RIGHT @"vote_slider_arrow_yes_right"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_YES_UP @"vote_slider_arrow_yes_up"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_YES_ROUND @"vote_slider_arrow_yes_round"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_NO_LEFT @"vote_slider_arrow_no_left"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_NO_RIGHT @"vote_slider_arrow_no_right"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_NO_DOWN @"vote_slider_arrow_no_down"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_NO_ROUND @"vote_slider_arrow_no_round"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_BG_LEFT @"vote_slider_bg_left"
#define SYNC_KEY_MEDIA_VOTE_SLIDER_BG_RIGHT @"vote_slider_bg_right"
#define SYNC_ARRAY_MEDIA_VOTE_SLIDER @[SYNC_KEY_MEDIA_VOTE_SLIDER_ALERT_BG_LEFT,SYNC_KEY_MEDIA_VOTE_SLIDER_ALERT_BG_RIGHT,SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_YES_LEFT,SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_YES_RIGHT,SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_YES_UP,SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_YES_ROUND,SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_NO_LEFT,SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_NO_RIGHT,SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_NO_DOWN,SYNC_KEY_MEDIA_VOTE_SLIDER_ARROW_NO_ROUND,SYNC_KEY_MEDIA_VOTE_SLIDER_BG_LEFT,SYNC_KEY_MEDIA_VOTE_SLIDER_BG_RIGHT]
#define SYNC_KEY_MEDIA_SCORE @"score"
#define SYNC_KEY_MEDIA_SCORE_BG @"score_bg"
#define SYNC_KEY_MEDIA_SCORE_BLUE_OFF @"score_blue_off"
#define SYNC_KEY_MEDIA_SCORE_BLUE_ON @"score_blue_on"
#define SYNC_KEY_MEDIA_SCORE_RED_OFF @"score_red_off"
#define SYNC_KEY_MEDIA_SCORE_RED_ON @"score_red_on"
#define SYNC_ARRAY_MEDIA_SCORE @[SYNC_KEY_MEDIA_SCORE_BG,SYNC_KEY_MEDIA_SCORE_BLUE_OFF,SYNC_KEY_MEDIA_SCORE_BLUE_ON,SYNC_KEY_MEDIA_SCORE_RED_OFF,SYNC_KEY_MEDIA_SCORE_RED_ON]
#define SYNC_KEY_MEDIA_LOADER @"loader"
#define SYNC_KEY_MEDIA_LOADER_BG @"loader_bg"
#define SYNC_KEY_MEDIA_LOADER_STAR_0 @"loader_star_0"
#define SYNC_KEY_MEDIA_LOADER_STAR_1 @"loader_star_1"
#define SYNC_KEY_MEDIA_LOADER_STAR_2 @"loader_star_2"
#define SYNC_KEY_MEDIA_LOADER_STAR_3 @"loader_star_3"
#define SYNC_ARRAY_MEDIA_LOADER @[SYNC_KEY_MEDIA_LOADER_BG,SYNC_KEY_MEDIA_LOADER_STAR_0,SYNC_KEY_MEDIA_LOADER_STAR_1,SYNC_KEY_MEDIA_LOADER_STAR_2,SYNC_KEY_MEDIA_LOADER_STAR_3]
#define SYNC_KEY_MEDIA_ALERT_ICON @"alert_icon"
#define SYNC_KEY_MEDIA_SETTINGS_NOTIFICATION_ICON @"settings_notification_icon"
#define SYNC_KEY_MEDIA_MEGAPHONE_ICON @"megaphone_icon"
#define SYNC_KEY_MEDIA_BG_ALERT @"bg_alert"
#define SYNC_KEY_MEDIA_BG_LOGIN @"bg_login"
#define SYNC_KEY_MEDIA_BG_SETTINGS @"bg_settings"
#define SYNC_KEY_MEDIA_BG_AGE_GATE @"bg_age_gate"
#define SYNC_KEY_MEDIA_ALERT_TOP_LINE @"alert_top_line"
#define SYNC_KEY_MEDIA_QUOTE_QUOTES @"quote_quotes"
#define SYNC_KEY_MEDIA_SPLASH @"splash"
#define SYNC_KEY_MEDIA_PLAY @"play"
#define SYNC_KEY_MEDIA_CREATOR_1 @"creator_1"
#define SYNC_KEY_MEDIA_CREATOR_2 @"creator_2"
#define SYNC_KEY_MEDIA_CAROUSEL_SHADOW @"carousel_shadow"
#define SYNC_KEY_MEDIA_SLIDER_MASK @"slider_mask"
#define SYNC_ARRAY_MEDIA_ALL @[SYNC_KEY_MEDIA_ALERT_ICON,SYNC_KEY_MEDIA_SETTINGS_NOTIFICATION_ICON,SYNC_KEY_MEDIA_MEGAPHONE_ICON,SYNC_KEY_MEDIA_BG_ALERT,SYNC_KEY_MEDIA_BG_AGE_GATE,SYNC_KEY_MEDIA_BG_LOGIN,SYNC_KEY_MEDIA_BG_SETTINGS,SYNC_KEY_MEDIA_ALERT_TOP_LINE,SYNC_KEY_MEDIA_QUOTE_QUOTES,SYNC_KEY_MEDIA_SPLASH,SYNC_KEY_MEDIA_PLAY,SYNC_KEY_MEDIA_CREATOR_1,SYNC_KEY_MEDIA_CREATOR_2,SYNC_KEY_MEDIA_CAROUSEL_SHADOW,SYNC_KEY_MEDIA_SLIDER_MASK]
#define SYNC_SOCIAL_NETWORK_FACEBOOK @"fb"
#define SYNC_SOCIAL_NETWORK_TWITTER @"tw"
#define SYNC_SOCIAL_NETWORK_GOOGLE_PLUS @"gp"
#define SYNC_SOCIAL_NETWORK_VK @"vk"
#define SYNC_SOCIAL_NETWORK_OK @"ok"
#define SYNC_SOCIAL_NETWORK_ANONYMOUS @"an"

//-----------------------------------------------------------//
//----------------- MISC
//-----------------------------------------------------------//
#pragma mark - misc
#define IMAGE_EXTENSION_PNG @".png"
#define IMAGE_EXTENSION_JPG @".jpg"












































