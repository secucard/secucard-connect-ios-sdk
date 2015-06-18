//
//  SCUserCredentials.m
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import "SCUserCredentials.h"

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

