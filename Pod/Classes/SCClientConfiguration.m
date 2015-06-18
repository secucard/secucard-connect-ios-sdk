//
//  SCClientConfiguration.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCClientConfiguration.h"

@implementation SCUserCredentials

- (instancetype) initWithUsername:(NSString*)username andPassword:(NSString*)password {
  self = [super init];
  if (self) {
    self.username = username;
    self.password = password;
  }
  return self;
}

@end

@implementation SCClientCredentials

- (instancetype) initWithClientId:(NSString*)clientId clientSecret:(NSString*)clientSecret {
  self = [super init];
  if (self) {
    self.clientId = clientId;
    self.clientSecret = clientSecret;
  }
  return self;
}

@end

@implementation SCClientConfiguration

- (instancetype) initWithRestConfiguration:(SCRestConfiguration*)restConfig stompConfiguration:(SCStompConfiguration*)stompConfig defaultChannel:(ServiceChannel)defaultChannel stompEnabled:(BOOL)stompEnabled oauthUrl:(NSString*)oauthUrl clientCredentials:(SCClientCredentials*)clientCredentials userCredentials:(SCUserCredentials*)userCredentials deviceId:(NSString*)deviceId authType:(NSString*)authType {
  
  self = [super init];
  if (self) {
    self.restConfiguration = restConfig;
    self.stompConfiguration = stompConfig;
    self.defaultChannel = defaultChannel;
    self.stompEnabled = stompEnabled;
    self.oauthUrl = oauthUrl;
    self.clientCredentials = clientCredentials;
    self.userCredentials = userCredentials;
    self.deviceId = deviceId;
    self.authType = authType;
  }
  return self;
  
}

#pragma mark - getters and setters

-(SCClientCredentials *)clientCredentials {
  if (!_clientCredentials) {
    _clientCredentials = [SCClientCredentials new];
  }
  return _clientCredentials;
}

-(SCUserCredentials *)userCredentials {
  if (!_userCredentials) {
    _userCredentials = [SCUserCredentials new];
  }
  return _userCredentials;
}

@end
