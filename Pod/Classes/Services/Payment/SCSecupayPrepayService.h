//
//  SCSecupayPrepaidService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCPaymentSecupayPrepay.h"

@interface SCSecupayPrepayService : SCAbstractService

/**
 *  get the service's singleton instance
 *
 *  @return the instance
 */
+ (SCSecupayPrepayService*)sharedService;

/**
 * Create a secupay prepay transaction.
 *
 * @param data     The prepay data.
 * @param callback Callback for async result processing.
 * @return The created transaction.
 */
- (PMKPromise*) createPrepay:(SCPaymentSecupayPrepay*)data;

/**
 * Cancel an existing prepay transaction.
 *
 * @param id       The prepay object id.
 * @param callback Callback for async processing.
 * @return
 */
- (PMKPromise*) cancelTransaction:(NSString*)id;

@end
