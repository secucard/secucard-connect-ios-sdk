
//
//  SCSecuObject.m
//  Pods
//
//  Created by Jörn Schmidt on 13.04.15.
//
//

#import "SCSecuObject.h"
#import "SCErrorManager.h"

@implementation SCSecuObject

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{};
}

+ (NSString*) object {
  [SCErrorManager handleError:[SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]];
  return @"";
}

@end
