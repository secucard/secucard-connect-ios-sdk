//
//  SCTransportStatus.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCTransportStatus.h"

@implementation SCTransportStatus

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"errorDetails":@"error_details",
           @"errorDescription":@"error_description",
           @"errorUser":@"error_user"
           };
}


@end
