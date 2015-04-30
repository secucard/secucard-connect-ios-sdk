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
  return @{
           @"cardNumber":@"cardnumber"
           };
}

@end
