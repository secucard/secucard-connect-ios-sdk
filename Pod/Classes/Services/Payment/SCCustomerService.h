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
 *  @return a promise resolveing with NSArray
 */
- (void) getCustomers:(SCQueryParams*)queryParams completionHandler:(void (^)(NSArray *list, SecuError *error))handler;

/**
 *  create a customer
 *
 *  @param customer the customer
 *
 *  @return a promise resolveing with SCPaymentCustomer
 */
- (void) createCustomer:(SCPaymentCustomer*)customer completionHandler:(void (^)(SCPaymentCustomer *, SecuError *))handler;

/**
 *  update a customer
 *
 *  @param customer the customer
 *
 *  @return a promise resolveing with SCPaymentCustomer
 */
- (void) updateCustomer:(SCPaymentCustomer*)customer completionHandler:(void (^)(SCPaymentCustomer *, SecuError *))handler;

/**
 *  delete a customer
 *
 *  @param id the customer's id
 *
 *  @return a promise resolveing with nil
 */
- (void) deleteCustomer:(NSString*)id completionHandler:(void (^)(bool success, SecuError *))handler;


@end
