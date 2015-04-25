//
//  SCSmartIdent.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartIdent.h"

@implementation SCSmartIdent

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"smart.idents";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"merchantCard":@"merchantcard"
           };
}

@end
