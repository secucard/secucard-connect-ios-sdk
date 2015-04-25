//
//  SCAuthSession.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCAuthSession.h"

@implementation SCAuthSession

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"auth.sessions";
  }
  return self;
}

@end
