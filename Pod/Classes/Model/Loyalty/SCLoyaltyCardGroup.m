//
//  SCLoyaltyCardGroup.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyCardGroup.h"

@implementation SCLoyaltyCardGroup

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"loyalty.cardgroups";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"displayName":@"display_name",
           @"displayNameRaw":@"display_name_raw",
           @"stockWarnLimit":@"stock_warn_limit"
           };
}


@end
