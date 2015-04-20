//
//  SCGeneralNotification.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralNotification.h"

@implementation SCGeneralNotification

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"general.notifications";
  }
  return self;
}
@end
