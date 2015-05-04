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
  return @"loyalty.cards";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"cardNumber":@"cardnumber"
           }];
}

@end
