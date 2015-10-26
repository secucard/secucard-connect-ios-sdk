//
//  SecucardAppCore.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 19.08.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCConnectClient.h"
#import "SCAccountManager.h"
#import "SCRestServiceManager.h"
#import "SCStompManager.h"

@implementation SCConnectClient

unsigned libVersionMajor = 0;
unsigned libVersionMinor = 2;
unsigned libVersionPatch = 10;

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
  
  self.configuration = configuration;
  
  [SCConnectClient sharedInstance].configuration = configuration;
  
  // also initialize AccountManager
  [[SCAccountManager sharedManager] initWithClientCredentials:configuration.clientCredentials andUserCredentials:configuration.userCredentials];
  
  // also  initalize rest
  [[SCRestServiceManager sharedManager] initWithConfiguration:configuration.restConfiguration];
  
  // also initialze stomp
  [[SCStompManager sharedManager] initWithConfiguration:configuration.stompConfiguration];
  
  self.initialized = TRUE;
  
}

- (NSString*) myApiVersion
{
  return [NSString stringWithFormat:@"%u.%u.%u", libVersionMajor, libVersionMinor, libVersionPatch];
}


- (void) setUserCredentials:(SCUserCredentials*)userCredentials {
  
  if (!self.configuration) {
    [SCLogManager errorWithDescription:@"You need to set the client configuration before setting user credentials"];
    return;
  }
  
  self.configuration.userCredentials = userCredentials;
  
}

- (void) connect:(void (^)(bool, NSError *))handler {
  
  if (_isConnecting) {
    handler(false, [SCLogManager makeErrorWithDescription:@"CONNECTTION: Already connecting"]);
    return;
  }
  
  _isConnecting = TRUE;
  
  if (self.connected) {
    _isConnecting = FALSE;
    handler(true, nil);
    return;
  }
  
  [[SCAccountManager sharedManager] token:^(NSString *token, NSError *error) {
    
    if (error != nil) {
      _isConnecting = FALSE;
      handler(false, error);
      return;
    }
    
    [[SCStompManager sharedManager] connect:^(bool success, NSError *error) {
      
      handler(success, error);
      
      _isConnecting = FALSE;
      
    }];
    
  }];
  
}

- (BOOL)connected {
  return [SCStompManager sharedManager].connected;
}

- (void)logoff:(void (^)(bool, NSError *))handler {
  
  [self disconnect:^(bool success, NSError *error) {
    
    if (error != nil) {
      [SCLogManager error:error];
    } else {
      [[SCAccountManager sharedManager] destroy];
      handler(true, nil);
    }
    
  }];
  
}

- (void)disconnect:(void (^)(bool success, NSError *error))handler {
  self.connected = false;
  [[SCStompManager sharedManager] close];
  [[SCRestServiceManager sharedManager] close];
  handler(true, nil);
}


- (void)destroy:(void (^)(bool success, NSError *))handler {
  
  [[SCRestServiceManager sharedManager] destroy];
  [[SCStompManager sharedManager] destroy];
  [[SCAccountManager sharedManager] destroy];
  self.configuration = nil;
  self.connected = FALSE;
  self.initialized = FALSE;
  
  handler(true, nil);
  
}


@end
