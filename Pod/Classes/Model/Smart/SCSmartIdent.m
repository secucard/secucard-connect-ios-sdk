//
//  SCSmartIdent.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartIdent.h"

@implementation SCSmartIdent

+ (NSString *)object {
  return @"smart.idents";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"merchantCard":@"merchantcard"
           };
}

@end
