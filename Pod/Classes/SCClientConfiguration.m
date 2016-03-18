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

#import "SCClientConfiguration.h"

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
