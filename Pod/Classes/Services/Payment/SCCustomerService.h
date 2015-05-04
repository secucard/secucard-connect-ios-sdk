//
//  SCCustomerService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCPaymentCustomer.h"
@interface SCCustomerService : SCAbstractService

/**
 *  get the service's singleton instance
 *
 *  @return the instance
 */
+ (SCCustomerService*)sharedService;

/**
 *  get a list if customers
 *
 *  @param queryParams the search paramters
 *
 *  @return a promise fulfilling with NSArray
 */
- (PMKPromise*) getCustomers:(SCQueryParams*)queryParams;

/**
 *  create a customer
 *
 *  @param customer the customer
 *
 *  @return a promise fulfilling with SCPaymentCustomer
 */
- (PMKPromise*) createCustomer:(SCPaymentCustomer*)customer;

/**
 *  update a customer
 *
 *  @param customer the customer
 *
 *  @return a promise fulfilling with SCPaymentCustomer
 */
- (PMKPromise*) updateCustomer:(SCPaymentCustomer*)customer;

/**
 *  delete a customer
 *
 *  @param id the customer's id
 *
 *  @return a promise fulfilling with nil
 */
- (PMKPromise*) deleteCustomer:(NSString*)id;


@end
