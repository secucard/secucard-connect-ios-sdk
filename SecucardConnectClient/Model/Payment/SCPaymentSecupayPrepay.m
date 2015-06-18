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
  return @"Payment.Secupayprepays";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"transferPurpose":@"transfer_purpose",
                                                                  @"transferAccount":@"transfer_account"
                                                                  }];
}


@end
