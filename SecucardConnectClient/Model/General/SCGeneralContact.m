//
//  SCGeneralContact.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralContact.h"
#import <Mantle/Mantle.h>

@implementation SCGeneralContact

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"dateOfBirth":@"dob",
                                                                  @"birthPlace":@"birthplace",
                                                                  @"companyName":@"companyname",
                                                                  @"urlWebsite":@"url_website"
                                                                  }];
}

+ (NSValueTransformer *)dateOfBirthJSONTransformer {
  
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateShortFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:value];
  }];
  
}

+ (NSValueTransformer *)addressJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralAddress class]];
}

@end
