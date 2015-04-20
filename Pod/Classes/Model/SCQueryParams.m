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
  return @{
           @"scrollId":@"scroll_id",
           @"scrollExpire":@"scroll_expire",
           @"fields":@"fields",
           @"sortOrder":@"sort",
           @"query":@"q",
           @"preset":@"preset",
           @"geoQuery":@"geo"
           };
}

//+ (NSValueTransformer *)fieldsJSONTransformer {
//  
//  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//    return nil;
//  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
//    return nil;
//  }];
//  
//}

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
