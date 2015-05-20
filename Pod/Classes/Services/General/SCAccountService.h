//
//  SCAccountService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"

#import "SCGeneralAccount.h"
#import "SCGeneralAccountDevice.h"
#import "SCGeneralBeaconEnvironment.h"
#import "SCGeneralEvent.h"
#import "SCGeneralLocation.h"

@interface SCAccountService : SCAbstractService

+ (SCAccountService*)sharedService;

/**
 *  creates an account
 *
 *  @param account the account to create
 *
 *  @return returns a promise which fulfills to SCGeneralAccount
 */
- (PMKPromise*) createAccount:(SCGeneralAccount*)account;

/**
 *  get an existing account
 *
 *  @param accountId the id to retrieve
 *
 *  @return returns a promise which fulfills to SCGeneralAccount
 */
- (PMKPromise*) getAccount:(NSString*)accountId;

/**
 *  update an existing account
 *
 *  @param account the account
 *
 *  @return returns a promise which fulfills to SCGeneralAccount
 */
- (PMKPromise*) updateAccount:(SCGeneralAccount*)account;

/**
 *  deletes ab account with the given id
 *
 *  @param accountId the account's id
 *
 *  @return returns a promise which fulfills to nil
 */
- (PMKPromise*) deleteAccount:(NSString*)accountId;

/**
 *  updates an location for the given account id
 *
 *  @param accountId the account's id
 *  @param location  the location to send
 *
 *  @return returns a promise which fulfills to nil
 */
- (PMKPromise*) updateLocation:(NSString*)accountId location:(SCGeneralLocation*)location;

/**
 *  updates the beacons for the account
 *
 *  @param accountId  the acount's if
 *  @param beaconList the list of beacons
 *
 *  @return returns a promise which fulfills to nil
 */
- (PMKPromise*) updateBeacons:(NSString*)accountId beachonList:(NSArray*)beaconList;

// TODO: compare to GCM function
//- (void) updateAPNS:(NSString*)accountId arg:(id)objectArg onComplete:(void(^)(BOOL success, NSError *error))completion;
  
@end
