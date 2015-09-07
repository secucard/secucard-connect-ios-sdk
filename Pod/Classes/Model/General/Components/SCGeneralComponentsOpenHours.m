//
//  SCGeneralComponentsOpenHours.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralComponentsOpenHours.h"

@implementation SCGeneralComponentsOpenHours

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)openJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralComponentsDayTime class]];
}

+ (NSValueTransformer *)closeJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralComponentsDayTime class]];
}

@end
