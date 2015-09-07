//
//  SCLoyaltyProgram.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyProgram.h"
#import "SCLoyaltyCondition.h"

@implementation SCLoyaltyProgram

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"descriptionText":@"description",
                                                                  @"cardGroup":@"cardgroup"
                                                                  }];
}

+ (NSValueTransformer *)cardGroupJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyCardGroup class]];
}

+ (NSValueTransformer *)conditionsJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[SCLoyaltyCondition class]];
}


@end
