//
//  SCAccountManager.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 30.09.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCAccountManager.h"
#import "SCAuthDeviceAuthCode.h"

@interface SCAccountManager()

@property (nonatomic, retain) SCClientCredentials *clientCredentials;
@property (nonatomic, retain) SCUserCredentials *userCredentials;

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
}

- (void) destroy {
  self.clientCredentials = nil;
  self.userCredentials = nil;
}

- (PMKPromise*) loginWithUserCedentials:(SCUserCredentials*)userCredentials
{
  
  _userCredentials = userCredentials;
  
  [[SCConnectClient sharedInstance] setUserCredentials:userCredentials];
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    [self retrieveAccessToken].then(^() {
      
      [SCPersistenceManager persist:_userCredentials.username forKey:kCredentialUsername];
      [SCPersistenceManager persist:_userCredentials.password forKey:kCredentialPassword];
      
      fulfill(nil);
      
    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
    
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
- (PMKPromise*) retrieveAccessToken
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    if ([self needsInitialization])
    {
      reject([SCErrorManager errorWithDescription:@"Account Manager not yet initialized" andDomain:kErrorDomainSCAccount]);
    }
    
    NSDictionary *params = @{
                             @"grant_type":@"appuser",
                             @"username": self.userCredentials.username,
                             @"password": self.userCredentials.password,
                             @"client_id": self.clientCredentials.clientId,
                             @"client_secret": self.clientCredentials.clientSecret,
                             @"device": [SCConnectClient sharedInstance].configuration.deviceId
                             };
    
    [[SCRestServiceManager sharedManager] requestAuthWithParams:params].then(^(NSDictionary *result) {
      
      self.accessToken = [result objectForKey:@"access_token"];
      self.refreshToken = [result objectForKey:@"refresh_token"];
      
      // get expires date
      NSNumber *interval = [result objectForKey:@"expires_in"];
      self.expires = [NSDate dateWithTimeIntervalSinceNow: [interval doubleValue]];
      
      // serialize
      [SCPersistenceManager persist:self.accessToken forKey:@"accessToken"];
      [SCPersistenceManager persist:self.refreshToken forKey:@"refreshToken"];
      [SCPersistenceManager persist:self.expires forKey:@"expires"];
      
      [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTokenDidGet object:nil];

      fulfill(self.accessToken);
      
    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
    
  }];
  
}

/**
 *  Retrieves an access token for device
 */
- (PMKPromise*) retrieveDeviceAccessToken:(SCAuthDeviceAuthCode*)code
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    if ([self needsInitialization])
    {
      reject([SCErrorManager errorWithDescription:@"Account Manager not yet initialized" andDomain:kErrorDomainSCAccount]);
    }
    
    NSDictionary *params = @{
                             @"grant_type":@"device",
                             @"client_id": self.clientCredentials.clientId,
                             @"client_secret": self.clientCredentials.clientSecret,
                             @"code": code.deviceCode
                             };
    
    [[SCRestServiceManager sharedManager] requestAuthWithParams:params].then(^(NSDictionary *result) {
      
      self.accessToken = [result objectForKey:@"access_token"];
      self.refreshToken = [result objectForKey:@"refresh_token"];
      
      // get expires date
      NSNumber *interval = [result objectForKey:@"expires_in"];
      self.expires = [NSDate dateWithTimeIntervalSinceNow: [interval doubleValue]];
      
      // serialize
      [SCPersistenceManager persist:self.accessToken forKey:@"accessToken"];
      [SCPersistenceManager persist:self.refreshToken forKey:@"refreshToken"];
      [SCPersistenceManager persist:self.expires forKey:@"expires"];
      
      [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTokenDidGet object:nil];
      
      fulfill(self.accessToken);
      
    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
    
  }];
  
}

/**
 *  Refreshes an access token
 */
- (PMKPromise*) refreshAccessToken
{
  
  // TODO: REMOVE, is only because of refresh token problem
  
//  [[SCAccountManager sharedManager] killToken:^(NSError *error) {
//    
//    [self token:completionBlock error:errorBlock];
//    
//  }];
//  
//  return;

  // END OF REMOVE
  
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    if ([self needsInitialization])
    {
      reject([SCErrorManager errorWithDescription:@"Account Manager not yet initialized" andDomain:kErrorDomainSCAccount]);
    }
    
    NSDictionary *params = @{
                             @"grant_type":@"refresh_token",
                             @"client_id": self.clientCredentials.clientId,
                             @"client_secret": self.clientCredentials.clientSecret,
                             @"refresh_token": self.refreshToken
                             };
    
    [[SCRestServiceManager sharedManager] requestAuthWithParams:params].then(^(NSDictionary *result) {
      
      self.accessToken = [result objectForKey:@"access_token"];
      
      // get expires date
      NSNumber *interval = [result objectForKey:@"expires_in"];
      self.expires = [NSDate dateWithTimeIntervalSinceNow: [interval doubleValue]];
      
      // serialize
      [SCPersistenceManager persist:self.accessToken forKey:@"accessToken"];
      [SCPersistenceManager persist:self.expires forKey:@"expires"];
      
      [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTokenDidRefresh object:nil];

      fulfill(self.accessToken);
      
    }).catch(^(NSError *error) {

      reject(error);
      
    });
    
  }];
  
}

/**
 *  Check if token is valid
 */
- (PMKPromise*) token
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    // if we are freshly there without any access token
    if (self.accessToken == nil)
    {
      
      // if we have user credentials, this is a regular auth process
      if (self.userCredentials) {
        
        [self retrieveAccessToken].then(^(NSString *token) {
          
          fulfill(token);
          
        }).catch(^(NSError *error) {
          
          reject(error);
          
        });
        
      } else if ([[SCConnectClient sharedInstance].configuration.authType isEqualToString:@"device"]) {
        
        // else this is a three-way auth process
        
        // request codes
        [self requestCode].then(^(SCAuthDeviceAuthCode *code) {
          
          return [self pollToken:code];
          
        }).then(^(NSString *token) {
          
          fulfill(token);
          
        }).catch(^(NSError *error) {
          
          reject(error);
          
        });
        
      }
      
    } else if (![self accessTokenValid]) {
      
      // or token is expired
      
      [self refreshAccessToken].then(^(NSString *token) {

        fulfill(token);
        
      }).catch(^(NSError *error) {
        
        reject(error);
        
      });
    } else {
      
      // or it is valid
      fulfill(self.accessToken);
      
    }
    
  }];
  
}
          
- (PMKPromise*) requestCode {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                  @"grant_type": @"device",
                                                                                  @"client_id": [SCConnectClient sharedInstance].configuration.clientCredentials.clientId,
                                                                                  @"client_secret": [SCConnectClient sharedInstance].configuration.clientCredentials.clientSecret,
                                                                                  @"uuid": [SCConnectClient sharedInstance].configuration.deviceId
                                                                                  }];
    
    [[SCRestServiceManager sharedManager] post:[SCConnectClient sharedInstance].configuration.restConfiguration.authUrl withParams:params].then(^(SCAuthDeviceAuthCode *code) {
      fulfill(code);
    }).catch(^(NSError *error) {
      reject(error);
    });
    
  }];
  
}

- (PMKPromise*) pollToken:(SCAuthDeviceAuthCode*)code {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    NSDate *now = [NSDate date];
    [NSTimer scheduledTimerWithTimeInterval:[code.interval floatValue] target:self selector:@selector(doPoll:) userInfo:@{@"code":code, @"fulfiller":fulfill, @"rejecter":reject, @"timerStart":now} repeats:TRUE];
    
  }];
  
}

- (void) doPoll:(NSTimer*)timer {
  
  SCAuthDeviceAuthCode *code = [timer.userInfo objectForKey:@"code"];
  NSDate *timerStart = [timer.userInfo objectForKey:@"timerStart"];
  PMKFulfiller fulfill = [timer.userInfo objectForKey:@"fulfiller"];
  PMKRejecter reject = [timer.userInfo objectForKey:@"rejecter"];
  
  // check if timer over expiration
  if ([code.expiresIn floatValue] > [[NSDate date] timeIntervalSinceDate:timerStart]) {
    reject([SCErrorManager errorWithCode:ERR_TOKEN_POLL_EXPIRED andDomain:kErrorDomainSCAccount]);
  }
  
  [self retrieveDeviceAccessToken:code].then(^(NSString *token) {
    fulfill(token);
  }).catch(^(NSError *error) {
    reject(error);
  });
  
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
