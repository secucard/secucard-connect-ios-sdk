//
//  SCLoyaltyCard.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyCard.h"

@implementation SCLoyaltyCard

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"loyalty.cards";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"cardNumber":@"cardnumber"
           }];
}


@end
