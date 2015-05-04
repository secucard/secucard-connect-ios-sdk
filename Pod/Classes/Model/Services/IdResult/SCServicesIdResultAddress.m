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
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"postalCode":@"postal_code",
                                                                  @"streetNumber":@"street_number"
                                                                  }];
}


@end
