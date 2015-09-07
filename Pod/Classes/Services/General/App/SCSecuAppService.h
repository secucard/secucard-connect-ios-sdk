//
//  SCSecuAppService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCGeneralMerchant.h"
@interface SCStoreList : SCObjectList



@end

@interface SCSecuAppService : SCAbstractService

/**
 *  get the ap's singleton instance
 *
 *  @return the instance
 */
+ (SCSecuAppService*)sharedService;

/**
 *  get the merchant with the given id
 *
 *  @param appId     the app id
 *  @param argObject an object with the store id and merchant id
 *
 *  @return a promise resolveing with SCGeneralMerchant
 */
- (void) getMerchant:(NSString*)appId argObject:(id)argObject completionHandler:(void (^)(SCObjectList *list, NSError *error))handler;

/**
 *  retrieve a lst of merchants
 *
 *  @param appId the app id
 *  @param arg   search paramters
 *
 *  @return a promise fulfiling with SCObjectList with SCGeneralMerchant
 */
- (void)getMerchants:(NSString *)appId arg:(SCQueryParams *)arg completionHandler:(void (^)(SCObjectList *list, NSError *error))handler;

/**
 *  add a card to the account
 *
 *  @param appId     the app id
 *  @param argObject an argument object with cardnumber and pin
 *
 *  @return a promise resolveing with nil
 */
- (void) addCard:(NSString*)appId argObject:(id)argObject completionHandler:(void (^)(bool success, NSError *))handler;

@end
