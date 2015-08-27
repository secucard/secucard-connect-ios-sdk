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
#import "SCLogManager.h"
#import "SCUserCredentials.h"
#import "SCClientCredentials.h"

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
#define kNotificationStompRefreshed         @"notificationStompConnectionRefreshed"

@protocol SCAccountManagerDelegate <NSObject>

@optional

- (void) accountManagerDidLogout;
- (void) accountManagerDidLogin;

@end

@interface SCAccountManager : NSObject

@property (nonatomic, retain) NSString *accessToken;
@property (nonatomic, retain) NSString *refreshToken;
@property (nonatomic, retain) NSDate *expires;
@property (nonatomic, assign) BOOL loggedIn;

@property (nonatomic, retain) id<SCAccountManagerDelegate> delegate;

+ (SCAccountManager*)sharedManager;

- (void) initWithClientCredentials:(SCClientCredentials*)clientCredentials andUserCredentials:(SCUserCredentials*)userCredentials;
- (void) destroy;
- (void) token:(void (^)(NSString *token, NSError *error))handler;
- (void) refreshAccessToken:(void (^)(NSString *token, NSError *error))handler;
- (void) killToken;
- (void) testInvalidateToken;

- (void) logout;
- (BOOL) accessTokenValid;
- (NSTimeInterval) accessTokenValidUntil;

@end
