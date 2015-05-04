//
//  SCCustomerService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"

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
 *  @return a promise fulfilling with SCLoyaltyCustomer
 */
- (PMKPromise*) getCustomer:(NSString*)id;
  
@end
