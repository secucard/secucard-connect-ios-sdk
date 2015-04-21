//
//  SCLoyaltyMerchantCard.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyMerchantCard.h"

@implementation SCLoyaltyMerchantCard

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"loyalty.merchantcards";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
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
