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
  return @"Smart.Devices";
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

+ (NSValueTransformer *)merchantJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralMerchant class]];
}

@end
