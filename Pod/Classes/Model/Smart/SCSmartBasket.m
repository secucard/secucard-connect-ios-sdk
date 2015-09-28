//
//  SCSmartBasket.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartBasket.h"
#import "SCSmartProduct.h"

@implementation SCSmartBasket

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)productsJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[SCSmartProduct class]];
}


@end
