//
//  SCPaymentContract.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentContract.h"

@implementation SCPaymentContract

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"payment.contracts";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"contractId":@"contract_id",
           @"internalReference":@"internal_reference"
           };
}

@end
