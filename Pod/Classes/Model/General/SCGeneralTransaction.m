//
//  SCGeneralTransaction.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralTransaction.h"

@implementation SCGeneralTransaction

+ (NSString *)object {
  return @"general.transactions";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"lastChange":@"last_change"
           };
}

@end
