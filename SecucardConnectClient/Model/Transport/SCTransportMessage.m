//
//  SCTransportMessage.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCTransportMessage.h"

@implementation SCTransportMessage

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *superKeys = [super JSONKeyPathsByPropertyKey];
  return [superKeys mtl_dictionaryByAddingEntriesFromDictionary:[NSDictionary mtl_identityPropertyMapWithModel:self]];
  
}

+ (NSValueTransformer *)queryJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCQueryParams class]];
}

@end
