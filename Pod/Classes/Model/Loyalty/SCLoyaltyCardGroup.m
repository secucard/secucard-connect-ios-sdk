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
  return @"Loyalty.Cardgroups";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"displayName":@"display_name",
                                                                  @"displayNameRaw":@"display_name_raw",
                                                                  @"stockWarnLimit":@"stock_warn_limit"
                                                                  }];
  
  
}

+ (NSValueTransformer *)merchantJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralMerchant class]];
}

+ (NSValueTransformer *)pictureObjectJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCMediaResource class]];
}


@end
