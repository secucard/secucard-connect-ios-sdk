//
//  SCGeneralAddress.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralAddress.h"

@implementation SCGeneralAddress

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"streetNumber":@"street_number",
           @"postalCode":@"postal_code"
           }];
}


@end
