//
//  SCGeneralMerchant.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralMerchant.h"

@implementation SCGeneralMerchant

+ (NSString *)object {
  return @"general.merchants";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"photoMain":@"photo_main"
           };
}

@end
