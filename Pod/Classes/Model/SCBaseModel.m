//
//  SCBaseModel.m
//  Pods
//
//  Created by Jörn Schmidt on 21.04.15.
//
//

#import "SCBaseModel.h"

@implementation SCBaseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

@end
