//
//  SCServicesIdResultPerson.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCServicesIdResultPerson.h"

@implementation SCServicesIdResultPerson

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"identificationProcess":@"identificationprocess",
           @"identificationDocument":@"identificationdocument",
           @"customData":@"customdata",
           @"contactData":@"contactdata",
           @"userData":@"userdata"
           };
}


@end
