//
//  SCObjectList.m
//  Pods
//
//  Created by Jörn Schmidt on 13.04.15.
//
//

#import "SCObjectList.h"

@implementation SCObjectList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                @"scrollId":@"scroll_id",
                                                                @"list":@"data"
                                                                }];
  
}

@end
