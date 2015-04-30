//
//  SCAccountManager.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 30.09.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCAccountManager.h"

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
                             @"device": @"sddsfsdf"
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
    
    if (self.accessToken == nil)
    {
      
      // check if did ever login already
      if (!self.userCredentials.username && !self.userCredentials.password) {
        reject([SCErrorManager errorWithDescription:@"No Credentials yet" andDomain:kErrorDomainSCAccount]);
      }
      else // else might have no token yet
      {

        [self retrieveAccessToken].then(^(NSString *token) {
          // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"ACCOUNT: Token: Got \nToken: %@\nRefresh Token: %@\nExires: %@", self.accessToken, self.refreshToken, self.expires]];
          fulfill(token);
        }).catch(^(NSError *error) {
          reject(error);
        });
        
      }
      
    }
    else if (![self accessTokenValid]) { // or token is expired
      
      // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"ACCOUNT: Token: Invalid, refresh"]];
      
      [self refreshAccessToken].then(^(NSString *token) {
        // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"ACCOUNT: Token: Got \nToken: %@\nRefresh Token: %@\nExires: %@", self.accessToken, self.refreshToken, self.expires]];
        fulfill(token);
      }).catch(^(NSError *error) {
        reject(error);
      });
    }
    else // or it is valid
    {
      // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"ACCOUNT: Token valid"]];
      fulfill(self.accessToken);
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

- (SCUserCredentials *)userCredentials {
  if (!_userCredentials) {
    _userCredentials = [SCUserCredentials new];
  }
  return _userCredentials;
}
@end
