//
//  SCCustomerService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCLoyaltyCustomer.h"
@interface SCLoyaltyCustomerService : SCAbstractService

/**
 *  get the service's singleton instance
 *
 *  @return the instance
 */
+ (SCLoyaltyCustomerService*)sharedService;

/**
 *  get a customer by it's id
 *
 *  @param id the customer's id
 *
 *  @return a promise resolveing with SCLoyaltyCustomer
 */
- (void) getCustomer:(NSString*)id completionHandler:(void (^)(SCLoyaltyCustomer *, SecuError *))handler;
  
@end
