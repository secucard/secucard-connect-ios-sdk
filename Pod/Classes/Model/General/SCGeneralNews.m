//
//  SCGeneralNews.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralNews.h"

@implementation SCGeneralNews

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"general.news";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"textTeaser":@"text_teaser",
           @"textFull":@"text_full",
           @"documentId":@"document_id",
           @"accountRead":@"_account_read"
           }];
}


@end
