//
//  SCSmartTransactionResult.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartTransactionResult.h"

@implementation SCSmartTransactionResult

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"paymentMethod":@"payment_method",
           @"receiptLines":@"receipt"
           }];
}


@end
