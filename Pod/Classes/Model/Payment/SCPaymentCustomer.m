//
//  SCPaymentCustomer.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentCustomer.h"

@implementation SCPaymentCustomer

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"payment.customers";
  }
  return self;
}
@end
