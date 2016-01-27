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
 *  @return returns a promise which resolves to SCGeneralAccount
 */
- (void) createAccount:(SCGeneralAccount*)account completionHandler:(void (^)(SCGeneralAccount *, SecuError *))handler;

/**
 *  get an existing account
 *
 *  @param accountId the id to retrieve
 *
 *  @return returns a promise which resolves to SCGeneralAccount
 */
- (void) getAccount:(NSString*)accountId completionHandler:(void (^)(SCGeneralAccount *, SecuError *))handler;

/**
 *  update an existing account
 *
 *  @param account the account
 *
 *  @return returns a promise which resolves to SCGeneralAccount
 */
- (void) updateAccount:(SCGeneralAccount*)account completionHandler:(void (^)(SCGeneralAccount *, SecuError *))handler;

/**
 *  deletes ab account with the given id
 *
 *  @param accountId the account's id
 *
 *  @return returns a promise which resolves to nil
 */
- (void) deleteAccount:(NSString*)accountId completionHandler:(void (^)(bool, SecuError *))handler;

/**
 *  updates an location for the given account id
 *
 *  @param accountId the account's id
 *  @param location  the location to send
 *
 *  @return returns a promise which resolves to nil
 */
- (void) updateLocation:(NSString*)accountId location:(SCGeneralLocation*)location completionHandler:(void (^)(bool, SecuError *))handler;

/**
 *  updates the beacons for the account
 *
 *  @param accountId  the acount's if
 *  @param beaconList the list of beacons
 *
 *  @return returns a promise which resolves to nil
 */
- (void) updateBeacons:(NSArray*)beaconList completionHandler:(void (^)(bool, SecuError *))handler;

- (void) passwordReset:(NSString*)email fromOrigin:(NSString*)origin completionHandler:(void (^)(bool, SecuError *))handler;

// TODO: compare to GCM function
//- (void) updateAPNS:(NSString*)accountId arg:(id)objectArg onComplete:(void(^)(BOOL success, SecuError *error))completion;
  
@end
