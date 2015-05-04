//
//  SCSecupayDebitService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCPaymentSecupayDebit.h"

@interface SCSecupayDebitService : SCAbstractService

/**
 *  get the service's singleton instance
 *
 *  @return the instance
 */
+ (SCSecupayDebitService*)sharedService;

/**
 *  Create a secupay debit transaction.
 *
 *  @param data the debit transaction
 *
 *  @return a promise fulfilling with SCPaymentSecupayDebit
 */
- (PMKPromise*) createTransaction:(SCPaymentSecupayDebit*)data;

/**
 *  Cancel an existing transaction.
 *
 *  @param id the transaction's id
 *
 *  @return a promise fulfilling with nil
 */
- (PMKPromise*) cancelTransaction:(NSString*)id;

@end
