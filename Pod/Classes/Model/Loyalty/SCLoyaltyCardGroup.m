//
//  SCLoyaltyCardGroup.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyCardGroup.h"

@implementation SCLoyaltyCardGroup

+ (NSString *)object {
  return @"loyalty.cardgroups";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"displayName":@"display_name",
           @"displayNameRaw":@"display_name_raw",
           @"stockWarnLimit":@"stock_warn_limit"
           };
}


@end
