//
//  SCTransactionService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCGeneralTransaction.h"

@interface SCTransactionService : SCAbstractService

// TODO: handle transaction changes

/**
 *  retrieve the services instance
 *
 *  @return the service's instance
 */
+ (SCTransactionService*)sharedService;

/**
 *  retrieve a list of transactions
 *
 *  @param queryParams the search paramters
 *
 *  @return a promise fulfilling with SCObjectList of SCGeneralTransaction
 */
- (PMKPromise*) getTransactions:(SCQueryParams*)queryParams;

/**
 *  retrieve a transaction by it's id
 *
 *  @param pid hte tranaction's id
 *
 *  @return a promise fulfilling with SCGeneralTransaction
 */
- (PMKPromise*) getTransaction:(NSString*)pid;
  
@end
