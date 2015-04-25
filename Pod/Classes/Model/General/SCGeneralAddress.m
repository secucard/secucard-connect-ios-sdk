//
//  SCGeneralAddress.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralAddress.h"

@implementation SCGeneralAddress

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"streetNumber":@"street_number",
           @"postalCode":@"postal_code"
           };
}


@end
