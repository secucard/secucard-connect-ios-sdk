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

  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"contractId":@"contract_id",
           @"internalReference":@"internal_reference"
           }];
}

@end
