//
//  SCAccountManager.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 30.09.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCAccountManager.h"

/**
 *  The AccountManager is secucard wrapper for the Social Login but also regular Login. It kan hold Login information and alike
 */
@implementation SCAccountManager

/**
 *  The client ID expected by the server
 */
NSString *thisClientId;

/**
 *  The client secret expected by the server
 */
NSString *thisClientSecret;

/**
 *   the user name to authenticate with
 */
NSString *thisUsername;

/**
 *   the password to authenticate with
 */
NSString *thisPassword;

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

- (void) setupWithClientId:(NSString*)clientId clientSecret:(NSString*)clientSecret
{
  
  thisClientId = clientId;
  thisClientSecret = clientSecret;
  
  if ([SCPersistenceManager keyExists:kCredentialUsername] && [SCPersistenceManager keyExists:kCredentialPassword]) {
    
    thisUsername = [SCPersistenceManager itemForKey:kCredentialUsername];
    thisPassword = [SCPersistenceManager itemForKey:kCredentialPassword];
    
  }
  
}

- (PMKPromise*) loginWithUsername:(NSString*)username andPassword:(NSString*)password
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    thisUsername = username;
    thisPassword = password;
    
    [self retrieveAccessToken].then(^() {
      
      [SCPersistenceManager persist:username forKey:kCredentialUsername];
      [SCPersistenceManager persist:password forKey:kCredentialPassword];
      
      fulfill(nil);
      
    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
    
  }];
  
}


- (BOOL) needsInitialization
{
  return (thisClientId == nil ||
          thisClientSecret == nil ||
          thisUsername == nil ||
          thisPassword == nil);
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
                             @"username": thisUsername,
                             @"password": thisPassword,
                             @"client_id": thisClientId,
                             @"client_secret": thisClientSecret,
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
                             @"client_id": thisClientId,
                             @"client_secret": thisClientSecret,
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
 *
 *  @param completionBlock sucess block
 *  @param errorBlock      error block
 */
- (PMKPromise*) token
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    if (self.accessToken == nil)
    {
      
      // check if did ever login already
      if (!thisUsername && !thisPassword) {
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
  
  thisUsername = nil;
  thisPassword = nil;
  
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
  
  // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"ACCOUNT: Token: Logged out"]];
  
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
