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
  return @"loyalty.sales";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"lastChange":@"last_change",
           @"descriptionString":@"description",
           @"descriptionRaw":@"description_raw",
           @"balanceAmount":@"balance_amount",
           @"balancePoints":@"balance_points"
           };
}


@end
