//
//  SCLoyaltyMerchantCard.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyMerchantCard.h"

@implementation SCLoyaltyMerchantCard

+ (NSString *)object {
  return @"loyalty.merchantcards";
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

@end
