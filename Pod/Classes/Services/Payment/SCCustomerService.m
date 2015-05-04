//
//  SCCustomerService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCCustomerService.h"

@implementation SCCustomerService

+ (SCCustomerService*)sharedService {
  
  static SCCustomerService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCCustomerService new];
  });
  
  return instance;
  
}

- (PMKPromise*) getCustomers:(SCQueryParams*)queryParams {
  
  return [self getList:[SCPaymentCustomer class] withParams:queryParams onChannel:DefaultChannel];
  
}

- (PMKPromise*) createCustomer:(SCPaymentCustomer*)customer {

  return [self create:customer onChannel:DefaultChannel];
  
}

- (PMKPromise*) updateCustomer:(SCPaymentCustomer*)customer {
  return [self update:customer onChannel:DefaultChannel];
}

- (PMKPromise*) deleteCustomer:(NSString*)id {
  return [self delete:[SCPaymentCustomer class] withId:id onChannel:DefaultChannel];
}


@end
