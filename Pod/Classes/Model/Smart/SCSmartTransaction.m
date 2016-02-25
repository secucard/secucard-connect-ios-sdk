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
  return @"Smart.Transactions";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"basketInfo":@"basket_info",
                                                                  @"deviceSource":@"device_source",
                                                                  @"targetDevice":@"target_device",
                                                                  @"paymentMethod":@"payment_method",
                                                                  @"receiptLines":@"receipt",
                                                                  @"receiptLinesMerchant":@"receipt_merchant",
                                                                  @"receiptLinesMerchantPrint":@"receipt_merchchant_print",
                                                                  @"paymentRequested":@"payment_requested",
                                                                  @"paymentExecuted":@"payment_executed"
                                                                  }];
}

+ (NSValueTransformer *)basketInfoJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCSmartBasketInfo class]];
}

+ (NSValueTransformer *)basketJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCSmartBasket class]];
}

+ (NSValueTransformer *)targetDeviceJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCSmartDevice class]];
}

+ (NSValueTransformer *)deviceSourceJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCSmartDevice class]];
}

+ (NSValueTransformer *)identsJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[SCSmartIdent class]];
}

+ (NSValueTransformer *)receiptLinesJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[SCSmartReceiptLine class]];
}

+ (NSValueTransformer *)createdJSONTransformer {
  
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:value];
  }];
  
}

+ (NSValueTransformer *)updatedJSONTransformer {
  
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter dateFromString:value];
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return [self.dateFormatter stringFromDate:value];
  }];
  
}

+ (NSValueTransformer *)receiptLinesMerchantPrintJSONTransformer {
  
  return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return value;
  } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
    return nil;
  }];
  
}


@end
