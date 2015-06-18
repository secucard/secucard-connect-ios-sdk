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
 *  @return a promise resolveing with SCObjectList of SCLoyaltyMerchantCard
 */
- (void) getMerchantCards:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *, NSError *))handler;

/**
 *  get a card by id
 *
 *  @param id the card's id
 *
 *  @return a promise resolveing with SCLoyaltyMerchantCard
 */
- (void) getMerchantCard:(NSString*)id completionHandler:(void (^)(SCLoyaltyMerchantCard *, NSError *))handler;

@end
