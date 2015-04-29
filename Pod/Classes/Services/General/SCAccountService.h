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

- (PMKPromise*) createAccount:(SCGeneralAccount*)account;
  
- (PMKPromise*) getAccount:(NSString*)accountId;
    
- (PMKPromise*) updateAccount:(SCGeneralAccount*)account;
      
- (PMKPromise*) deleteAccount:(NSString*)accountId;
        
- (PMKPromise*) updateLocation:(NSString*)accountId location:(SCGeneralLocation*)location;
          
- (PMKPromise*) updateBeacons:(NSString*)accountId beachonList:(NSArray*)beaconList;

// TODO: compare to GCM function
//- (void) updateAPNS:(NSString*)accountId arg:(id)objectArg onComplete:(void(^)(BOOL success, NSError *error))completion;
  
@end
