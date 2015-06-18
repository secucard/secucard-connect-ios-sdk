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


@end
