//
//  SCSmartDevice.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartDevice.h"

@implementation SCSmartDevice

+ (NSString *)object {
  return @"smart.devices";
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
