//
//  SecucardAppCore.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 19.08.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCConnectClient.h"

@implementation SCConnectClient

+ (SCConnectClient *)sharedInstance
{
  static SCConnectClient *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCConnectClient new];
  });
  
  return instance;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    
  }
  return self;
}

- (void) initWithConfiguration:(SCClientConfiguration*)configuration {
  
  
  [SCConnectClient sharedInstance].configuration = configuration;
  
  // also initialize AccountManager
  [[SCAccountManager sharedManager] initWithClientCredentials:[SCConnectClient sharedInstance].configuration.clientCredentials];
  
  // also  initalize rest
  [[SCRestServiceManager sharedManager] initWithConfiguration:[SCConnectClient sharedInstance].configuration.restConfiguration];
  
  // also initialze stomp
  [[SCStompManager sharedManager] initWithConfiguration:[SCConnectClient sharedInstance].configuration.stompConfiguration];
  
  
  
}

- (void) setUserCredentials:(SCUserCredentials*)userCredentials {
  
  if (!self.configuration) {
    [SCErrorManager handleErrorWithDescription:@"You need to set the client configuration before setting user credentials"];
    return;
  }
  
  self.configuration.userCredentials = userCredentials;
  
}

- (void) connect:(void (^)(bool, NSError *))handler {
  
  if (self.connected) {
    handler(true, nil);
    return;
  }
  
  [[SCAccountManager sharedManager] token:^(NSString *token, NSError *error) {
    
    if (error != nil) {
      handler(false, error);
      return;
    }
    
    [[SCStompManager sharedManager] connect:^(bool success, NSError *error) {
      handler(success, error);
    }];
    
  }];
  
}

- (void)disconnect:(void (^)(bool, NSError *))handler {
  
  handler(nil, [SCErrorManager errorWithDescription:@"not implemented"]);
  
}

- (void)destroy:(void (^)(bool, NSError *))handler {
  
  [[SCRestServiceManager sharedManager] destroy];
  [[SCStompManager sharedManager] destroy];
  [[SCAccountManager sharedManager] destroy];
  self.configuration = nil;
  self.connected = false;
  
  handler(true, nil);
  
}


@end
