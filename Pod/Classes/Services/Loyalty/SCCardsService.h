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
 *  @return a promise fulfilling with SCLoyaltyCard
 */
- (PMKPromise*) getCard:(NSString*)id;

/**
 *  get a list of cards
 *
 *  @param queryParams the search paramters
 *
 *  @return a promise fulfilling with SCObjectList with SCLoyaltyCard
 */
- (PMKPromise*) getCards:(SCQueryParams*)queryParams;

/**
 *  Assign a card to the user
 *
 *  @param cardNumber the card number
 *  @param pin        the pin of the card
 *
 *  @return a promise fulfilling with nil
 */
- (PMKPromise*) assignUserToCard:(NSString*)cardNumber pin:(id)pin;

/**
 *  remove a card from the user
 *
 *  @param cardNumber the card number
 *
 *  @return a promise fulfilling with nil
 */
- (PMKPromise*) deleteUserFromCard:(NSString*)cardNumber;

@end
