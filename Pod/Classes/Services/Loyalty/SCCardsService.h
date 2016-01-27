//
//  SCCardsService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCLoyaltyCard.h"

@interface SCCardsService : SCAbstractService

/**
 *  get the service's singleton instance
 *
 *  @return the instance
 */
+ (SCCardsService*)sharedService;

/**
 *  get a card by id
 *
 *  @param id the card's id
 *
 *  @return a promise resolveing with SCLoyaltyCard
 */
- (void) getCard:(NSString*)id completionHandler:(void (^)(SCLoyaltyCard *, SecuError *))handler;

/**
 *  get a list of cards
 *
 *  @param queryParams the search paramters
 *
 *  @return a promise resolveing with SCObjectList with SCLoyaltyCard
 */
- (void) getCards:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *, SecuError *))handler;

/**
 *  Assign a card to the user
 *
 *  @param cardNumber the card number
 *  @param pin        the pin of the card
 *
 *  @return a promise resolveing with nil
 */
- (void) assignUserToCard:(NSString*)cardNumber pin:(id)pin completionHandler:(void (^)(bool, SecuError *))handler;

/**
 *  remove a card from the user
 *
 *  @param cardNumber the card number
 *
 *  @return a promise resolveing with nil
 */
- (void) deleteUserFromCard:(NSString*)cardNumber completionHandler:(void (^)(bool, SecuError *))handler;

@end
