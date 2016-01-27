//
//  SCStoreService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCGeneralStore.h"
#import "SCGeneralStoreSetDefault.h"

@interface SCStoreService : SCAbstractService

/**
 *  get instance of service
 *
 *  @return the singleton instance
 */
+ (SCStoreService*)sharedService;


/**
 *  check-in to a store
 *
 *  @param storeId the store's id
 *  @param sid
 *
 *  @return a promise resolveing to nil
 */
- (void) checkIn:(NSString*) storeId sid:(NSString*)sid completionHandler:(void (^)(bool success, SecuError *error))handler;

/**
 *  set store as default
 *
 *  @param storeId the store's id
 *  @param set default payload
 *  @return a promise resolveing to nil
 */
- (void)setDefault:(NSString *)storeId withReason:(SCGeneralStoreSetDefault*)reason completionHandler:(void (^)(bool, SecuError *))handler;

/**
 *  set store as default
 *
 *  @param storeId the store's id
 *  @return a promise resolveing to nil
 */
- (void)setDefault:(NSString *)storeId completionHandler:(void (^)(bool, SecuError *))handler;

/**
 *  retrieve a list of stores
 *
 *  @param queryParams the search paramteres
 *
 *  @return a promise resolveing to SCObjectList of SCGeneralStore
 */
- (void) getStores:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *stores, SecuError *error))handler;

/**
 *  retrieve a list of stores
 *
 *  @param queryParams the search paramteres
 *
 *  @return a promise resolveing to NSarray of SCGeneralStore
 */
- (void) getStoreList:(SCQueryParams*)queryParams completionHandler:(void (^)(NSArray *storeList, SecuError *error))handler;

/**
 *  get a store by search query
 *
 *  @param pid         the store id
 *
 *  @return a promise resolveing to SCGeneralStore
 */
- (void) getStore:(NSString*)pid completionHandler:(void (^)(SCGeneralStore *store, SecuError *error))handler;

@end
