//
//  SCLoyaltyCustomer.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyCustomer.h"

@implementation SCLoyaltyCustomer

+ (NSDateFormatter *)dateFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
  return dateFormatter;
}

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

+ (NSValueTransformer *)merchantJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralMerchant class]];
}

+ (NSValueTransformer *)pictureObjectJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCMediaResource class]];
}

+ (NSValueTransformer *)dateOfBirthJSONTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:value];
  }];
}



@end
