//
//  SCLoyaltyCondition.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyCondition.h"

@implementation SCLoyaltyCondition

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"startValue":@"start_value",
                                                                  @"currency":@"curreny",
                                                                  @"bonusType":@"bonus_type"
                                                                  }];
}


@end
