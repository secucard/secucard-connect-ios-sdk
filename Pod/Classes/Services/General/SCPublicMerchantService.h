//
//  PublicMerchantService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>
#import "SCAbstractService.h"
#import "SCGeneralPublicMerchant.h"

@interface SCPublicMerchantService : SCAbstractService

/**
 *  get instance of service
 *
 *  @return the singleton instance
 */
+ (SCPublicMerchantService*)sharedService;

/**
 *  retireve the public merchant with the given id
 *
 *  @param id the merchant's id
 *
 *  @return returns a promise which resolves to SCGeneralPublicMerchant
 */
- (void) getPublicMerchant:(NSString*)id completionHandler:(void (^)(SCGeneralPublicMerchant *, SecuError *))handler;

/**
 *  Get a lit of public merchants
 *
 *  @param params the search parameters
 *
 *  @return returns a promise which resolves to SCObjectList containing SCGeneralPublicMerchant
 */
- (void) getPublicMerchants:(SCQueryParams*)params completionHandler:(void (^)(SCObjectList *, SecuError *))handler;

@end
