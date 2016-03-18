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

#import "SCStompConfiguration.h"

@implementation SCStompConfiguration

- (instancetype) initWithHost:(NSString *)host andVHost:(NSString *)virtualHost port:(int)port userId:(NSString *)userId password:(NSString *)password useSSL:(BOOL)useSsl replyQueue:(NSString *)replyQueue connectionTimeoutSec:(int)connectionTimeoutSec socketTimeoutSec:(int)socketTimeoutSec heartbeatMs:(int)heartbeatMs basicDestination:(NSString *)basicDestination {
  
  self = [super init];
  if (self) {
    self.host = host;
    self.virtualHost = virtualHost;
    self.port = port;
    self.userId = userId;
    self.password = password;
    self.useSsl = useSsl;
    self.replyQueue = replyQueue;
    self.connectionTimeoutSec = connectionTimeoutSec;
    self.socketTimeoutSec = socketTimeoutSec;
    self.heartbeatMs = heartbeatMs;
    self.basicDestination = basicDestination;
  }
  return self;
  
}

@end
