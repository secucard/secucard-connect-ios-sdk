//
//  SCPaymentSecupayPrepay.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentSecupayPrepay.h"

@implementation SCPaymentSecupayPrepay

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"payment.secupayprepays";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"transferPurpose":@"transfer_purpose",
           @"transferAccount":@"transfer_account"
           }];
}


@end
