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

@interface SCAccountManager()

@property (nonatomic, retain) SCClientCredentials *clientCredentials;
@property (nonatomic, retain) SCUserCredentials *userCredentials;
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
  });
  
  return instance;
}

- (void) initWithClientCredentials:(SCClientCredentials*)clientCredentials
{
  _clientCredentials = clientCredentials;
  
  if (self.refreshToken) {
    NSLog(@"REFRESHTOKEN: %@", [SCPersistenceManager itemForKey:@"refreshToken"]);
  }
}

- (void) destroy {
  self.clientCredentials = nil;
  self.userCredentials = nil;
}

- (void) loginWithUserCedentials:(SCUserCredentials*)userCredentials completionHandler:(void (^)(BOOL success, NSError *error))handler
{
  
  _userCredentials = userCredentials;
  
  [[SCConnectClient sharedInstance] setUserCredentials:userCredentials];
  
    [self retrieveAccessToken:^(NSString *token, NSError *error) {
      
      if (error != nil) {
        [SCPersistenceManager persist:_userCredentials.username forKey:kCredentialUsername];
        [SCPersistenceManager persist:_userCredentials.password forKey:kCredentialPassword];
      }
      
      handler(error != nil, error);
      
    }];
  
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
                           @"username": self.userCredentials.username,
                           @"password": self.userCredentials.password,
                           @"client_id": self.clientCredentials.clientId,
                           @"client_secret": self.clientCredentials.clientSecret,
                           @"device": [SCConnectClient sharedInstance].configuration.deviceId
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

/**
 *  Check if token is valid
 */
- (void) token:(void (^)(NSString *token, NSError *error))handler
{
  
  // if we are freshly there without any access token
  if (self.accessToken == nil)
  {
    
    // if we have user credentials, this is a regular auth process
    if (self.userCredentials) {
      
      [self retrieveAccessToken:^(NSString *token, NSError *error) {
        handler(token, error);
        return;
      }];
      
    } else if ([[SCConnectClient sharedInstance].configuration.authType isEqualToString:@"device"]) {
      
      // else this is a three-way auth process
      
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
    
  } else if (![self accessTokenValid]) {
    
    // or token is expired
    
    [self refreshAccessToken:^(NSString *token, NSError *error) {
      handler(token, error);
      return;
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
  
  [NSTimer scheduledTimerWithTimeInterval:[code.interval floatValue] target:self selector:@selector(doPoll:) userInfo:@{@"code":code, @"timerStart":now} repeats:TRUE];
  
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
      }
      
    } else {
      
      [timer invalidate];
      weakSelf.devicePollHandler(deviceAccessToken, nil);
      
    }
    
  }];
  
}

- (void) logout
{
  
  [SCPersistenceManager removeItemForKey:kCredentialUsername];
  [SCPersistenceManager removeItemForKey:kCredentialPassword];
  
  self.userCredentials = nil;
  
  [self killToken];
  
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
