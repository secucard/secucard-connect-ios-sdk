/******************************************
 *
 *  Copyright (c) 2015. hp.weber GmbH & Co secucard KG (www.secucard.com)
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 ******************************************/

#import "SCQueryParams.h"

@implementation SCQueryParams

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"scrollId":@"scroll_id",
                                                                  @"scrollExpire":@"scroll_expire",
                                                                  @"fields":@"fields",
                                                                  @"sortOrder":@"sort",
                                                                  @"query":@"q",
                                                                  @"preset":@"preset",
                                                                  @"geoQuery":@"geo"
                                                                  }];
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
