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

- (instancetype) initWithConfiguration:(SCClientConfiguration*)configuration {
  
  self = [self init];
  if (self) {
    self.configuration = configuration;
    
    // also  initalize rest
    [[SCRestServiceManager sharedManager] initWithConfiguration:self.configuration.restConfiguration];
    
    // also initialze stomp
    [[SCStompManager sharedManager] initWithConfiguration:self.configuration.stompConfiguration];
    
    // also initialize AccountManager
    [[SCAccountManager sharedManager] initWithClientCredentials:self.configuration.clientCredentials];
  }
  return self;
  
}

- (void) setUserCredentials:(SCUserCredentials*)userCredentials {
  
  if (!self.configuration) {
    [SCErrorManager handleErrorWithDescription:@"You need to set the client configuration before setting user credentials"];
    return;
  }
  
  self.configuration.userCredentials = userCredentials;
  
}

- (PMKPromise*) connect {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    if (self.connected) {
      fulfill(nil);
    }
    
    [[SCAccountManager sharedManager] token].then(^(NSString *token) {

      [[SCStompManager sharedManager] connect].then(^() {
        
        fulfill(nil);
        
      });

    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
    
    // initialize stomp
    
  }];
  
}

- (PMKPromise*) disconnect {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    [SCErrorManager handleError:[SCErrorManager errorWithDescription:@"not implemented"]];
  }];
          
}


@end
