//
//  SCStompServiceConfiguration.m
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

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
