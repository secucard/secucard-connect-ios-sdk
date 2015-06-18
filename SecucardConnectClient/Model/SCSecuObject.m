
//
//  SCSecuObject.m
//  Pods
//
//  Created by Jörn Schmidt on 13.04.15.
//
//

#import "SCSecuObject.h"
#import "SCLogManager.h"

@implementation SCSecuObject

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSString*) object {
  [SCLogManager error:[SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]];
  return @"";
}

@end
