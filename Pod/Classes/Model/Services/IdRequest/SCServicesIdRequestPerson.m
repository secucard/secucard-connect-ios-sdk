//
//  SCServicesIdRequestPerson.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCServicesIdRequestPerson.h"

@implementation SCServicesIdRequestPerson

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"transactionId":@"transaction_id",
                                                                  @"redirectUrl":@"redirect_url",
                                                                  @"ownerTransactionId":@"owner_transaction_id"
                                                                  }];
}


@end
