//
//  SCMerchantCardsService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCLoyaltyMerchantCard.h"

@interface SCMerchantCardsService : SCAbstractService

/**
 *  get the service's singleton instance
 *
 *  @return the instance
 */
+ (SCMerchantCardsService*)sharedService;

/**
 *  get a list of cards
 *
 *  @param queryParams the search paramters
 *
 *  @return a promise fulfilling with SCObjectList of SCLoyaltyMerchantCard
 */
- (PMKPromise*) getMerchantCards:(SCQueryParams*)queryParams;

/**
 *  get a card by id
 *
 *  @param id the card's id
 *
 *  @return a promise fulfilling with SCLoyaltyMerchantCard
 */
- (PMKPromise*) getMerchantCard:(NSString*)id;

@end
