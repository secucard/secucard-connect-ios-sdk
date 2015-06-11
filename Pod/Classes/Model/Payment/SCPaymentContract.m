//
//  SCPaymentContract.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentContract.h"

@implementation SCPaymentContract

+ (NSString *)object {
  return @"Payment.Contracts";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"contractId":@"contract_id",
                                                                  @"internalReference":@"internal_reference"
                                                                  }];
}

@end
