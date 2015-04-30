//
//  SCPaymentSecupayPrepay.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentSecupayPrepay.h"

@implementation SCPaymentSecupayPrepay

+ (NSString *)object {
  return @"payment.secupayprepays";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"transferPurpose":@"transfer_purpose",
           @"transferAccount":@"transfer_account"
           };
}


@end
