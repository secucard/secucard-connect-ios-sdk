//
//  SCGeneralMerchant.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralMerchant.h"

@implementation SCGeneralMerchant

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"general.merchants";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"photoMain":@"photo_main"
           };
}

@end
