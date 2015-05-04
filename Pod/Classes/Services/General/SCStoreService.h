//
//  SCStoreService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCGeneralStore.h"

@interface SCStoreService : SCAbstractService

/**
 *  check-in to a store
 *
 *  @param storeId the store's id
 *  @param sid
 *
 *  @return a promise fulfilling to nil
 */
- (PMKPromise*) checkIn:(NSString*) storeId sid:(NSString*)sid;

/**
 *  set store as default
 *
 *  @param storeId the store's id
 *
 *  @return a promise fulfilling to nil
 */
- (PMKPromise*) setDefault:(NSString*)storeId;

/**
 *  retrieve a list of stores
 *
 *  @param queryParams the search paramteres
 *
 *  @return a promise fulfilling to SCObjectList of SCGeneralStore
 */
- (PMKPromise*) getStores:(SCQueryParams*)queryParams;

/**
 *  retrieve a list of stores
 *
 *  @param queryParams the search paramteres
 *
 *  @return a promise fulfilling to NSarray of SCGeneralStore
 */
- (PMKPromise*) getStoreList:(SCQueryParams*)queryParams;

/**
 *  get a store by search query
 *
 *  @param pid         the store id
 *
 *  @return a promise fulfilling to SCGeneralStore
 */
- (PMKPromise*) getStore:(NSString*)pid;

@end
