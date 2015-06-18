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
 *  @return a promise resolveing with SCObjectList of SCGeneralTransaction
 */
- (void) getTransactions:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *, NSError *))handler;

/**
 *  retrieve a transaction by it's id
 *
 *  @param pid hte tranaction's id
 *
 *  @return a promise resolveing with SCGeneralTransaction
 */
- (void) getTransaction:(NSString*)pid completionHandler:(void (^)(SCGeneralTransaction *, NSError *))handler;
  
@end
