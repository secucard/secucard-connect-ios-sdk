//
//  SCGeoQuery.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCGeoQuery.h"

@implementation SCGeoQuery

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"field":@"field",
                                                                  @"distance":@"distance",
                                                                  @"lat":@"lat",
                                                                  @"lon":@"lon"
                                                                  }];
}

@end
