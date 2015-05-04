//
//  PublicMerchantService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>
#import "SCAbstractService.h"

@interface SCPublicMerchantService : SCAbstractService

/**
 *  retireve the public merchant with the given id
 *
 *  @param id the merchant's id
 *
 *  @return returns a promise which fulfills to SCGeneralPublicMerchant
 */
- (PMKPromise*) getPublicMerchant:(NSString*)id;

/**
 *  Get a lit of public merchants
 *
 *  @param params the search parameters
 *
 *  @return returns a promise which fulfills to SCObjectList containing SCGeneralPublicMerchant
 */
- (PMKPromise*) getPublicMerchants:(SCQueryParams*)params;

@end
