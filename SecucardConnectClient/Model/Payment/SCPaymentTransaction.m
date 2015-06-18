//
//  SCPaymentTransaction.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentTransaction.h"

@implementation SCPaymentTransaction

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"orderId":@"order_id",
                                                                  @"transId":@"trans_id",
                                                                  @"transactionStatus":@"transaction_status"
                                                                  }];
}


@end
