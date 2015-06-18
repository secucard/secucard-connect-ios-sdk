//
//  SCPaymentTransferAccount.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentTransferAccount.h"

@implementation SCPaymentTransferAccount

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"accountOwner":@"account_owner",
                                                                  @"accountNumber":@"accountnumber",
                                                                  @"bankCode":@"bankcode"
                                                                  }];
}


@end
