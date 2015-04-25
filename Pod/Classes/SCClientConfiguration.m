//
//  SCClientConfiguration.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCClientConfiguration.h"

@implementation SCUserCredentials

@end

@implementation SCClientCredentials

@end

@implementation SCClientConfiguration


#pragma mark - getters and setters

-(SCClientCredentials *)clientCredentials {
  if (!self.clientCredentials) {
    self.clientCredentials = [SCClientCredentials new];
  }
  return self.clientCredentials;
}

-(SCUserCredentials *)userCredentials {
  if (!self.userCredentials) {
    self.userCredentials = [SCUserCredentials new];
  }
  return self.userCredentials;
}

@end
