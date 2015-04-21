//
//  SCGeneralMerchantDetail.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralMerchantDetail.h"

@implementation SCGeneralMerchantDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"news":@"_news",
           @"balance":@"_balance",
           @"points":@"_points"
           }];
}


@end
