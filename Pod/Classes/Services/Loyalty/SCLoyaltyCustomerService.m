//
//  SCCustomerService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCLoyaltyCustomerService.h"
#import "SCLoyaltyCustomer.h"

@implementation SCLoyaltyCustomerService

+ (SCLoyaltyCustomerService*)sharedService {
  
  static SCLoyaltyCustomerService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCLoyaltyCustomerService new];
  });
  
  return instance;
  
}

- (PMKPromise*) getCustomer:(NSString*)id {
  
  return [self get:[SCLoyaltyCustomer class] withId:id onChannel:DefaultChannel];
  
}


@end
