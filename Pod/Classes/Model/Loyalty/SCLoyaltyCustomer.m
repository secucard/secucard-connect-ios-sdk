//
//  SCLoyaltyCustomer.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCLoyaltyCustomer.h"
#import "SCGlobals.h"

@implementation SCLoyaltyCustomer

+ (NSString *)object {
  return @"Loyalty.Customers";
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

+ (NSValueTransformer *)contactJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralContact class]];
}

+ (NSValueTransformer *)dateOfBirthJSONTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [SCGlobals.dateFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [SCGlobals.dateFormatter stringFromDate:value];
  }];
}



@end
