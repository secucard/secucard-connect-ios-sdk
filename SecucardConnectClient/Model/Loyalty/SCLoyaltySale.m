//
//  SCLoyaltySale.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltySale.h"

@implementation SCLoyaltySale

+ (NSString *)object {
  return @"Loyalty.Sales";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary: @{
                                                                   @"lastChange":@"last_change",
                                                                   @"descriptionString":@"description",
                                                                   @"descriptionRaw":@"description_raw",
                                                                   @"balanceAmount":@"balance_amount",
                                                                   @"balancePoints":@"balance_points"
                                                                   }];
}

+ (NSValueTransformer *)storeJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralStore class]];
}

+ (NSValueTransformer *)cardJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyCard class]];
}

+ (NSValueTransformer *)cardgroupJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyCardGroup class]];
}

+ (NSValueTransformer *)merchantcardJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyMerchantCard class]];
}

+ (NSValueTransformer *)lastChangeJSONTransformer {
  
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:value];
  }];
  
}

@end
