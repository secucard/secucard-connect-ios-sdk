//
//  SCSmartDevice.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartDevice.h"

@implementation SCSmartDevice

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"smart.devices";
  }
  return self;
}

- (instancetype)initWithId:(NSString*)identifier andType:(NSString*)type
{
  self = [super init];
  if (self) {
    self.id = identifier;
    self.type = type;
  }
  return self;
}
@end
