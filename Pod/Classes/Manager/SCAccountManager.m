//
//  SCAccountManager.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 30.09.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCAccountManager.h"
#import "SCAuthDeviceAuthCode.h"
#import "SCRestServiceManager.h"
#import "SCStompManager.h"
#import "SCConnectClient.h"

@interface SCAccountManager()

@property (nonatomic, retain) SCClientCredentials *clientCredentials;
@property (nonatomic, retain) SCUserCredentials *userCredentials;

@property (nonatomic, retain) NSTimer *pollingTimer;
@property (nonatomic, copy) void (^devicePollHandler)(NSString *, NSError *);

@end

/**
 *  The AccountManager is secucard wrapper for the Social Login but also regular Login. It kan hold Login information and alike
 */
@implementation SCAccountManager

/**
 *  Shared manager as singleton
 *
 *  @return the manager instance
 */
+ (SCAccountManager *)sharedManager
{
  static SCAccountManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCAccountManager new];
    instance.alwaysRemindConnecting = false;
  });
  
  return instance;
}

- (void) initWithClientCredentials:(SCClientCredentials*)clientCredentials andUserCredentials:(SCUserCredentials*)userCredentials
{
  _clientCredentials = clientCredentials;
  _userCredentials = userCredentials;
  
  if (self.refreshToken) {
    NSLog(@"REFRESHTOKEN: %@", [SCPersistenceManager itemForKey:@"refreshToken"]);
  }
}

- (void) destroy {
  self.clientCredentials = nil;
  self.userCredentials = nil;
  self.accessToken = nil;
  self.refreshToken = nil;
  self.expires = nil;
  [self killToken];
}

- (BOOL) needsInitialization
{
  return (self.clientCredentials == nil);
}

/**
 *  checks if token is valid
 */
- (BOOL) accessTokenValid
{
  return ( self.accessToken && [self.expires compare:[NSDate date]] != NSOrderedAscending);
}

/**
 *  returns amount of seconds to become invalid
 */
- (NSTimeInterval) accessTokenValidUntil
{
  return ([self.expires timeIntervalSinceNow]);
}

/**
 *  Retrieves an access token
 */
- (void) retrieveAccessToken:(void (^)(NSString *token, NSError *error))handler
{
  
  if ([self needsInitialization])
  {
    handler(false, [SCLogManager makeErrorWithDescription:@"Account Manager not yet initialized" andDomain:kErrorDomainSCAccount]);
  }
  
  NSDictionary *params = @{
                           @"grant_type":@"appuser",
                           @"username": [SCConnectClient sharedInstance].configuration.userCredentials.username,
                           @"password": [SCConnectClient sharedInstance].configuration.userCredentials.password,
                           @"client_id": self.clientCredentials.clientId,
                           @"client_secret": self.clientCredentials.clientSecret,
                           @"device": [SCConnectClient sharedInstance].configuration.deviceId
                           };
  
  [[SCRestServiceManager sharedManager] requestAuthWithParams:params completionHandler:^(id responseObject, NSError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    [SCPersistenceManager persist:self.userCredentials.username forKey:kCredentialUsername];
    [SCPersistenceManager persist:self.userCredentials.password forKey:kCredentialPassword];
    
    self.accessToken = [responseObject objectForKey:@"access_token"];
    self.refreshToken = [responseObject objectForKey:@"refresh_token"];
    
    // get expires date
    NSNumber *interval = [responseObject objectForKey:@"expires_in"];
    self.expires = [NSDate dateWithTimeIntervalSinceNow: [interval doubleValue]];
    
    // serialize
    [SCPersistenceManager persist:self.accessToken forKey:@"accessToken"];
    [SCPersistenceManager persist:self.refreshToken forKey:@"refreshToken"];
    [SCPersistenceManager persist:self.expires forKey:@"expires"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTokenDidGet object:nil];
    
    if ([self.delegate respondsToSelector:@selector(accountManagerDidLogin)]) {
      [self.delegate accountManagerDidLogin];
    }
    
    handler(self.accessToken, nil);
    
  }];
  
}

/**
 *  Retrieves an access token for device
 */
- (void) retrieveDeviceAccessToken:(SCAuthDeviceAuthCode*)code completionHandler:(void (^)(NSString *deviceAccessToken, NSError *error))handler;
{
  
  if ([self needsInitialization])
  {
    handler(nil, [SCLogManager makeErrorWithDescription:@"Account Manager not yet initialized" andDomain:kErrorDomainSCAccount]);
  }
  
  NSDictionary *params = @{
                           @"grant_type":@"device",
                           @"client_id": self.clientCredentials.clientId,
                           @"client_secret": self.clientCredentials.clientSecret,
                           @"code": code.deviceCode
                           };
  
  [[SCRestServiceManager sharedManager] requestAuthWithParams:params completionHandler:^(id responseObject, NSError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    self.accessToken = [responseObject objectForKey:@"access_token"];
    self.refreshToken = [responseObject objectForKey:@"refresh_token"];
    
    // get expires date
    NSNumber *interval = [responseObject objectForKey:@"expires_in"];
    self.expires = [NSDate dateWithTimeIntervalSinceNow: [interval doubleValue]];
    
    // serialize
    [SCPersistenceManager persist:self.accessToken forKey:@"accessToken"];
    [SCPersistenceManager persist:self.refreshToken forKey:@"refreshToken"];
    [SCPersistenceManager persist:self.expires forKey:@"expires"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTokenDidGet object:nil];
    
    handler(self.accessToken, nil);
    
  }];
  
}

/**
 *  Refreshes an access token
 */
- (void) refreshAccessToken:(void (^)(NSString *token, NSError *error))handler
{
  
  if ([self needsInitialization])
  {
    handler(nil, [SCLogManager makeErrorWithDescription:@"Account Manager not yet initialized" andDomain:kErrorDomainSCAccount]);
  }
  
  NSDictionary *params = @{
                           @"grant_type":@"refresh_token",
                           @"client_id": self.clientCredentials.clientId,
                           @"client_secret": self.clientCredentials.clientSecret,
                           @"refresh_token": self.refreshToken
                           };
  
  [[SCRestServiceManager sharedManager] requestAuthWithParams:params completionHandler:^(id responseObject, NSError *error) {
    
    if (error) {
      handler(nil, error);
      return;
    }
    
    self.accessToken = [responseObject objectForKey:@"access_token"];
    
    // get expires date
    NSNumber *interval = [responseObject objectForKey:@"expires_in"];
    self.expires = [NSDate dateWithTimeIntervalSinceNow: [interval doubleValue]];
    
    // serialize
    [SCPersistenceManager persist:self.accessToken forKey:@"accessToken"];
    [SCPersistenceManager persist:self.expires forKey:@"expires"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTokenDidRefresh object:nil];
    
    handler(self.accessToken, nil);
    
  }];
  
}

- (NSString *)username {
  
  if (self.userCredentials && self.userCredentials.username) {
    return self.userCredentials.username;
  } else {
    return (NSString*)[SCPersistenceManager itemForKey:kCredentialUsername];
  }
  
}

- (NSString *)password {
  
  if (self.userCredentials && self.userCredentials.password) {
    return self.userCredentials.password;
  } else {
    return (NSString*)[SCPersistenceManager itemForKey:kCredentialPassword];
  }
  
}

- (void) requestTokenWithDeviceAuth:(void (^)(NSString *token, NSError *error))handler {
  
  // request codes
  [self requestCode:^(SCAuthDeviceAuthCode *code, NSError *error) {
    
    if (error) {
      handler(nil, error);
      return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deviceAuthCodeRequesting" object:nil userInfo:@{@"code":code}];
    
    [self pollToken:code completionHandler:handler];
    
  }];
  
}

/**
 *  Check if token is valid
 */
- (void) token:(void (^)(NSString *token, NSError *error))handler
{
  
  // if we are freshly there without any access token
  if (self.accessToken == nil)
  {
    
    // if we have user credentials, this is a regular auth process
    if ([SCConnectClient sharedInstance].configuration.userCredentials.username && [SCConnectClient sharedInstance].configuration.userCredentials.password) {
      
      [self retrieveAccessToken:^(NSString *token, NSError *error) {
        handler(token, error);
        return;
      }];
      
    } else if ([[SCConnectClient sharedInstance].configuration.authType isEqualToString:@"device"] && self.alwaysRemindConnecting) {
      
      // else this is a three-way auth process
      [self requestTokenWithDeviceAuth:handler];
    }
    
  } else if (![self accessTokenValid]) {
    
    // or token is expired
    
    [self refreshAccessToken:^(NSString *token, NSError *error) {
      
      [SCLogManager info:[NSString stringWithFormat:@"TOKEN: refreshed Token: %@", token]];
      
      // reconnect stomp
      [[SCStompManager sharedManager] refreshConnection:^(bool success, NSError *error) {
        
        handler(token, error);
        return;
        
      }];
      
    }];
    
  } else {
    
    // or it is valid
    handler(self.accessToken, nil);
    return;
    
  }
  
}

- (void) requestCode:(void (^)(SCAuthDeviceAuthCode *code, NSError *error))handler {
  
  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                @"grant_type": @"device",
                                                                                @"client_id": [SCConnectClient sharedInstance].configuration.clientCredentials.clientId,
                                                                                @"client_secret": [SCConnectClient sharedInstance].configuration.clientCredentials.clientSecret,
                                                                                @"uuid": [SCConnectClient sharedInstance].configuration.deviceId
                                                                                }];
  
  [[SCRestServiceManager sharedManager] post:@"oauth/token" withAuth:FALSE withParams:params completionHandler:^(id responseObject, NSError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    SCAuthDeviceAuthCode *code = [MTLJSONAdapter modelOfClass:SCAuthDeviceAuthCode.class fromJSONDictionary:responseObject error:&parsingError];
    
    if (parsingError != nil) {
      handler(nil, parsingError);
      return;
    }
    
    handler(code, nil);
    
  }];
  
}

- (void) pollToken:(SCAuthDeviceAuthCode*)code completionHandler:(void (^)(NSString *token, NSError *error))handler {
  
  NSLog(@"Insert code: %@ on site %@", code.userCode, code.verificationUrl);
  
  NSDate *now = [NSDate date];
  
  self.devicePollHandler = handler;
  
  self.pollingTimer = [NSTimer scheduledTimerWithTimeInterval:[code.interval floatValue] target:self selector:@selector(doPoll:) userInfo:@{@"code":code, @"timerStart":now} repeats:TRUE];
  
}

- (void) stopPollingToken {
  
  [self.pollingTimer invalidate];
  self.pollingTimer = nil;
  
}

- (void) doPoll:(NSTimer*)timer {
  
  SCAuthDeviceAuthCode *code = [timer.userInfo objectForKey:@"code"];
  NSDate *timerStart = [timer.userInfo objectForKey:@"timerStart"];
  
  // check if timer over expiration
  NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:timerStart];
  
  if ([code.expiresIn floatValue] < elapsedTime) {
    self.devicePollHandler(nil, [SCLogManager makeErrorWithCode:ERR_TOKEN_POLL_EXPIRED andDomain:kErrorDomainSCAccount]);
  }
  
  __weak __block SCAccountManager *weakSelf = self;
  
  [self retrieveDeviceAccessToken:code completionHandler:^(NSString *deviceAccessToken, NSError *error) {
    
    // TODO: check error number for 401 (should be if no code from user so far)
    if (error != nil) {
      
      // do not resolve when Error 401 as this is regular when user didn't enter the code
      if (![error.localizedDescription containsString:@"401"]) {
        weakSelf.devicePollHandler(nil, error);
        
        // stop polling
        [weakSelf stopPollingToken];
        
      }
      
    } else {
      
      [weakSelf stopPollingToken];
      weakSelf.devicePollHandler(deviceAccessToken, nil);
      
    }
    
  }];
  
}

- (void) logout
{
  
  [[SCStompManager sharedManager] close];
  [[SCRestServiceManager sharedManager] close];
  
  [SCPersistenceManager removeItemForKey:kCredentialUsername];
  [SCPersistenceManager removeItemForKey:kCredentialPassword];
  
  [self killToken];
  
  if ([self.delegate respondsToSelector:@selector(accountManagerDidLogout)]) {
    [self.delegate accountManagerDidLogout];
  }
  
}

- (BOOL)loggedIn {
  
  return ([SCPersistenceManager keyExists:kCredentialUsername] && [SCPersistenceManager keyExists:kCredentialPassword]);
  
}

- (void) killToken
{
  
  [SCPersistenceManager removeItemForKey:kAccessToken];
  [SCPersistenceManager removeItemForKey:kRefreshToken];
  [SCPersistenceManager removeItemForKey:kAccessTokenExpires];
  
  self.accessToken = nil;
  self.refreshToken = nil;
  self.expires = nil;
  
  [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTokenDidLogout object:nil];
  
}

- (void) testInvalidateToken {
  [SCPersistenceManager persist:[NSDate dateWithTimeIntervalSinceNow:-1000] forKey:@"expires"];
}

- (NSString*) accessToken
{
  if (_accessToken == nil)
  {
    _accessToken = [SCPersistenceManager itemForKey:@"accessToken"];
  }
  return _accessToken;
}

- (NSString*) refreshToken
{
  if (!_refreshToken)
  {
    return [SCPersistenceManager itemForKey:@"refreshToken"];
  }
  return _refreshToken;
}

- (NSDate*) expires
{
  if (!_expires)
  {
    _expires = [SCPersistenceManager itemForKey:@"expires"];
  }
  return _expires;
  
}
@end
