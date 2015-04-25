//
//  SCGeneralAccount.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralAccount.h"

@implementation SCGeneralAccount

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"general.accounts";
  }
  return self;
}

@end
