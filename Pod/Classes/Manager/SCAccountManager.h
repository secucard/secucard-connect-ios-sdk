//
//  SCAccountManager.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 30.09.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SCConnectClient.h"
#import "SCPersistenceManager.h"
#import "SCErrorManager.h"

@class SCUserCredentials;
@class SCClientCredentials;

#define kErrorDomainSCAccount               @"SCSecucardCoreAccount"

#define kCredentialUsername                 @"credientialUsername"
#define kCredentialPassword                 @"credientialPassword"

#define kAccessToken                        @"accessToken"
#define kRefreshToken                       @"refreshToken"
#define kAccessTokenExpires                 @"expires"

#define kNotificationNoCredentials          @"notificationNoCredentials"
#define kNotificationSociallyLoggedIn       @"notificationLoggedIn"
#define kNotificationSociallyLoggedOut      @"notificationLoggedOut"
#define kNotificationTokenDidLogout         @"notificationTokenDidLogout"
#define kNotificationTokenStillHave         @"notificationTokenStillHave"
#define kNotificationTokenDidGet            @"notificationTokenDidGet"
#define kNotificationTokenDidRefresh        @"notificationTokenDidRefresh"

@interface SCAccountManager : NSObject

@property (nonatomic, retain) NSString *accessToken;
@property (nonatomic, retain) NSString *refreshToken;
@property (nonatomic, retain) NSDate *expires;

+ (SCAccountManager*)sharedManager;

- (void) initWithClientCredentials:(SCClientCredentials*)clientCredentials;
- (void) destroy;
- (void) loginWithUserCedentials:(SCUserCredentials*)userCredentials completionHandler:(void (^)(BOOL success, NSError *error))handler;
- (void) token:(void (^)(NSString *token, NSError *error))handler;
- (void) refreshAccessToken:(void (^)(NSString *token, NSError *error))handler;
- (void) killToken;

- (BOOL) accessTokenValid;
- (NSTimeInterval) accessTokenValidUntil;

@end
