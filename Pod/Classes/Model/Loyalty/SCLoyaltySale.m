//
//  SCLoyaltySale.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltySale.h"

@implementation SCLoyaltySale

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"loyalty.sales";
  }
  return self;
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
