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
  return @{
           @"orderId":@"order_id",
           @"transId":@"trans_id",
           @"transactionStatus":@"transaction_status"
           };
}


@end
