//
//  SCLoyaltyCustomer.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyCustomer.h"

@implementation SCLoyaltyCustomer

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"loyalty.customers";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"foreName":@"forename",
           @"surName":@"surname",
           @"displayName":@"display_name",
           @"daysUntilBirthday":@"days_until_birthday",
           @"additionalData":@"additional_data",
           @"customerNumber":@"customernumber",
           @"dateOfBirth":@"dob"
           };
}


@end
