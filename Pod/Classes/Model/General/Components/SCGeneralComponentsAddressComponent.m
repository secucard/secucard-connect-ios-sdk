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
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"longName":@"long_name",
                                                                  @"shortName":@"short_name"
                                                                  }];
}


@end
