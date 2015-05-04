//
//  SCLoyaltyCustomer.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyCustomer.h"

@implementation SCLoyaltyCustomer

+ (NSString *)object {
  return @"loyalty.customers";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"foreName":@"forename",
                                                                  @"surName":@"surname",
                                                                  @"displayName":@"display_name",
                                                                  @"daysUntilBirthday":@"days_until_birthday",
                                                                  @"additionalData":@"additional_data",
                                                                  @"customerNumber":@"customernumber",
                                                                  @"dateOfBirth":@"dob"
                                                                  }];
}


@end
