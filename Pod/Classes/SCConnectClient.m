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

#import "SCConnectClient.h"
#import "SCAccountManager.h"
#import "SCRestServiceManager.h"
#import "SCStompManager.h"

@implementation SCConnectClient

unsigned libVersionMajor = 0;
unsigned libVersionMinor = 2;
unsigned libVersionPatch = 12;

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

- (void) connect:(void (^)(bool, SecuError *))handler {
  
  if (_isConnecting) {
//    handler(false, [SCLogManager makeErrorWithDescription:@"CONNECTION: Already connecting"]);
    return;
  }
  
  _isConnecting = TRUE;
  
  if (self.connected) {
    _isConnecting = FALSE;
    handler(true, nil);
    return;
  }
  
  [[SCAccountManager sharedManager] token:^(NSString *token, SecuError *error) {
    
    if (error != nil) {
      _isConnecting = FALSE;
      handler(false, error);
      return;
    }
    
    [[SCStompManager sharedManager] connect:^(bool success, SecuError *error) {
      
      handler(success, error);
      
      _isConnecting = FALSE;
      
    }];
    
  }];
  
}

- (BOOL)connected {
  return [SCStompManager sharedManager].connected;
}

- (void)logoff:(void (^)(bool, SecuError *))handler {
  
  [self disconnect:^(bool success, SecuError *error) {
    
    if (error != nil) {
      [SCLogManager error:error];
    } else {
      [[SCAccountManager sharedManager] destroy];
      handler(true, nil);
    }
    
  }];
  
}

- (void)disconnect:(void (^)(bool success, SecuError *error))handler {
  self.connected = false;
  [[SCStompManager sharedManager] close];
  [[SCRestServiceManager sharedManager] close];
  handler(true, nil);
}


- (void)destroy:(void (^)(bool success, SecuError *))handler {
  
  [[SCRestServiceManager sharedManager] destroy];
  [[SCStompManager sharedManager] destroy];
  [[SCAccountManager sharedManager] destroy];
  self.configuration = nil;
  self.connected = FALSE;
  self.initialized = FALSE;
  
  handler(true, nil);
  
}


@end
