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
                                                                         @"display": @(EventTypeDisplay)
                                                                         }];
}

@end
