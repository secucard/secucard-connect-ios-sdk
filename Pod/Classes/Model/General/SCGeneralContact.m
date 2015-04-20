//
//  SCGeneralContact.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralContact.h"

@implementation SCGeneralContact

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"dateOfBirth":@"dob",
           @"birthPlace":@"birthplace",
           @"companyName":@"companyname",
           @"urlWebsite":@"url_website"
           };
}


@end
