//
//  SCGeneralComponentsAddressComponent.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralComponentsAddressComponent.h"

@implementation SCGeneralComponentsAddressComponent

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"longName":@"long_name",
           @"shortName":@"short_name"
           }];
}


@end
