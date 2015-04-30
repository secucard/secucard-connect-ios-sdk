//
//  SCServicesIdentResult.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCServicesIdentResult.h"

@implementation SCServicesIdentResult

+ (NSString *)object {
  return @"services.identresults";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"persons":@"person"
           };
}


@end
