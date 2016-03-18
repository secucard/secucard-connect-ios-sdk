/******************************************
 *
 *  Copyright (c) 2015. hp.weber GmbH & Co secucard KG (www.secucard.com)
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 ******************************************/

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
@property (nonatomic, assign) BOOL alwaysRemindConnecting;

@property (nonatomic, retain) id<SCAccountManagerDelegate> delegate;

+ (SCAccountManager*)sharedManager;

- (void) initWithClientCredentials:(SCClientCredentials*)clientCredentials andUserCredentials:(SCUserCredentials*)userCredentials;
- (void) destroy;
- (void) requestTokenWithDeviceAuth:(void (^)(NSString *token, SecuError *error))handler;
- (void) token:(void (^)(NSString *token, SecuError *error))handler;
- (void) refreshAccessToken:(void (^)(NSString *token, SecuError *error))handler;
- (void) killToken;
- (void) testInvalidateToken;
- (void) stopPollingToken;

- (void) logout;
- (BOOL) accessTokenValid;
- (NSTimeInterval) accessTokenValidUntil;

@end
