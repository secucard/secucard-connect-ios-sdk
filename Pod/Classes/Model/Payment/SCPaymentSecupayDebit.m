//
//  SCPaymentSecupayDebit.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentSecupayDebit.h"

@implementation SCPaymentSecupayDebit

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"payment.secupaydebits";
  }
  return self;
}
@end
