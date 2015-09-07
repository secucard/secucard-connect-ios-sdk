//
//  SCGeneralEvent.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralEvent.h"

@implementation SCGeneralEvent

+ (NSValueTransformer *)typeJSONTransformer {
  return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
                                                                         @"changed": @(EventTypeChanged),
                                                                         @"added": @(EventTypeAdded),
                                                                         @"display": @(EventTypeDisplay),
                                                                         @"BeaconMonitor": @(EventTypeBeaconMonitor),
                                                                         }];
}

+ (NSValueTransformer *)createdJSONTransformer {
  
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:value];
  }];
  
}


@end
