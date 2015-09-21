//
//  SCSmartCheckin.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartCheckin.h"


@implementation SCSmartCheckin

+ (NSString *)object {
  return @"Smart.Checkins";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"merchantCard":@"merchantcard"
                                                                  }];
}

+ (NSValueTransformer *)accountJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralAccount class]];
}

+ (NSValueTransformer *)merchantCardJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyMerchantCard class]];
}

+ (NSValueTransformer *)customerJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyCustomer class]];
}

+ (NSValueTransformer *)pictureObjectJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCMediaResource class]];
}

+ (NSValueTransformer *)createdJSONTransformer {
  
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:value];
  }];
  
}

@end
