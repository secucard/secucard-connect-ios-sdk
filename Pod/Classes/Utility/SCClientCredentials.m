//
//  SCClientCredentials.m
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import "SCClientCredentials.h"

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
