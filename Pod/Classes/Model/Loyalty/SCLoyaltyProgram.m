//
//  SCLoyaltyProgram.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyProgram.h"

@implementation SCLoyaltyProgram

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"descriptionText":@"description",
                                                                  @"cardGroup":@"cardgroup"
                                                                  }];
}


@end
