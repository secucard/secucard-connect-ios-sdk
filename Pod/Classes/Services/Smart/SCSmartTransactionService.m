//
//  SCTransactionService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCSmartTransactionService.h"
#import "SCSmartTransaction.h"

@implementation SCSmartTransactionService

/**
 *  Create a transaction
 *
 *  @param transaction the transaction to create
 *
 *  @return a promise fulfilling with a SCSmartTransaction
 */
- (PMKPromise*) createTransaction:(SCSmartTransaction*)transaction {
  return [self create:transaction onChannel:DefaultChannel];
}

/**
 * Updating a transaction.
 *
 * @param transaction The transaction data to update.
 *
 * @return a promise fulfilling with SCSmartTransaction
 */
- (PMKPromise*) updateTransaction:(SCSmartTransaction*)transaction {
  return [self update:transaction onChannel:DefaultChannel];
}

/**
 * Starting/Executing a transaction.
 *
 * @param transactionId The transaction id.
 * @param type          The transaction type like "auto" or "cash".
 *
 * @return a promise fulfilling with SCSmartTransaction
 */
- (PMKPromise*) startTransaction:(NSString*)transactionId type:(NSString*)type {
  return [self execute:[SCSmartTransaction class] withId:transactionId action:@"start" actionArg:type arg:nil returnType:[SCSmartTransaction class] onChannel:StompChannel];
}

@end
