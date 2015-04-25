//
//  SCGeoQuery.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCGeoQuery.h"

@implementation SCGeoQuery

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"field":@"field",
           @"distance":@"distance",
           @"lat":@"lat",
           @"lon":@"lon"
           };
}

@end
