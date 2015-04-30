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
  return @"payment.contracts";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"contractId":@"contract_id",
           @"internalReference":@"internal_reference"
           };
}

@end
