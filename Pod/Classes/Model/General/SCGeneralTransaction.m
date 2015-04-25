//
//  SCGeneralTransaction.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralTransaction.h"

@implementation SCGeneralTransaction

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"general.transactions";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"lastChange":@"last_change"
           };
}

@end
