//
//  SCGeneralNews.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralNews.h"

@implementation SCGeneralNews

+ (NSString *)object {
  return @"General.News";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"textTeaser":@"text_teaser",
                                                                  @"textFull":@"text_full",
                                                                  @"documentId":@"document_id",
                                                                  @"accountRead":@"_account_read"
                                                                  }];
}

+ (NSValueTransformer *)createdJSONTransformer {
  
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:value];
  }];
  
}


@end
