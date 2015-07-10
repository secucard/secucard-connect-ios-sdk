//
//  SCLoyaltyCard.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyCard.h"

@implementation SCLoyaltyCard

+ (NSString *)object {
  return @"Loyalty.Cards";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"cardNumber":@"cardnumber"
           }];
}

+ (NSValueTransformer *)accountJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralAccount class]];
}

+ (NSValueTransformer *)createdJSONTransformer {
  
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:value];
  }];
  
}


@end
