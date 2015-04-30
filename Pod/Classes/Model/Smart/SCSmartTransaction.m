//
//  SCSmartTransaction.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartTransaction.h"

@implementation SCSmartTransaction

+ (NSString *)object {
  return @"smart.transactions";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"basketInfo":@"basket_info",
           @"deviceSource":@"device_source",
           @"targetDevice":@"target_device",
           @"paymentMethod":@"payment_method",
           @"receiptLines":@"receipt",
           @"paymentRequested":@"payment_requested",
           @"paymentExecuted":@"payment_executed"
           };
}


@end
