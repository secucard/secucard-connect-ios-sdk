//
//  QueryParams.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCQueryParams.h"

@implementation SCQueryParams


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"scrollId":@"scroll_id",
           @"scrollExpire":@"scroll_expire",
           @"sortOrder":@"sort",
           @"query":@"q",
           @"geoQuery":@"geo"
           }];
}

+ (NSValueTransformer *)geoQueryJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:SCGeoQuery.class];
}


- (void) addSortOrder:(NSString*)order forField:(NSString*)field {
  if (self.sortOrder == nil) {
    self.sortOrder = [NSMutableDictionary new];
  }
  [self.sortOrder setObject:order forKey:field];
}

@end
