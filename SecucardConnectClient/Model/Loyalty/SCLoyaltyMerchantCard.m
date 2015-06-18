  //
//  SCLoyaltyMerchantCard.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyMerchantCard.h"
#import "SCGlobals.h"

@implementation SCLoyaltyMerchantCard

+ (NSString *)object {
  return @"Loyalty.Merchantcards";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"createdForMerchant":@"created_for_merchant",
                                                                  @"createdForStore":@"created_for_store",
                                                                  @"isBaseCard":@"is_base_card",
                                                                  @"lastUsage":@"last_usage",
                                                                  @"lastCharge":@"last_charge",
                                                                  @"stockStatus":@"stock_status",
                                                                  @"lockStatus":@"lock_status"
                                                                  }];
}

+ (NSValueTransformer *)merchantJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralMerchant class]];
}

+ (NSValueTransformer *)createdForMerchantJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralMerchant class]];
}

+ (NSValueTransformer *)cardJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyCard class]];
}

+ (NSValueTransformer *)createdForStoreJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralStore class]];
}

+ (NSValueTransformer *)cardgroupJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyCardGroup class]];
}

+ (NSValueTransformer *)customerJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyCustomer class]];
}

+ (NSValueTransformer *)lastUsageJSONTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [SCGlobals.dateFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [SCGlobals.dateFormatter stringFromDate:value];
  }];
}

+ (NSValueTransformer *)lastChargeJSONTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [SCGlobals.dateFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [SCGlobals.dateFormatter stringFromDate:value];
  }];
}

@end
