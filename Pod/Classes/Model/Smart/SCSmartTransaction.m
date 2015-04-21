//
//  SCSmartTransaction.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartTransaction.h"

@implementation SCSmartTransaction

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"smart.transactions";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"basketInfo":@"basket_info",
           @"deviceSource":@"device_source",
           @"targetDevice":@"target_device",
           @"paymentMethod":@"payment_method",
           @"receiptLines":@"receipt",
           @"paymentRequested":@"payment_requested",
           @"paymentExecuted":@"payment_executed"
           }];
}


@end
