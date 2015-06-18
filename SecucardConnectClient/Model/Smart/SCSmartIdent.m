//
//  SCSmartIdent.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartIdent.h"

@implementation SCSmartIdent

+ (NSString *)object {
  return @"Smart.Idents";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"merchantCard":@"merchantcard"
                                                                  }];
}

+ (NSValueTransformer *)customerJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyCustomer class]];
}

+ (NSValueTransformer *)merchantCardJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyMerchantCard class]];
}


@end
