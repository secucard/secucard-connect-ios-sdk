//
//  SCServicesIdResultAddress.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCServicesIdResultAddress.h"

@implementation SCServicesIdResultAddress

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"postalCode":@"postal_code",
           @"streetNumber":@"street_number"
           }];
  
}


@end
