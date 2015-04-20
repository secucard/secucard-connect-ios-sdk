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

- (void) createAccount:(SCGeneralAccount*)account onComplete:(void(^)(SCGeneralAccount *account, NSError *error))completion;
  
- (void) getAccount:(NSString*)id onComplete:(void(^)(SCGeneralAccount *account, NSError *error))completion;
    
- (void) updateAccount:(SCGeneralAccount*)account onComplete:(void(^)(SCGeneralAccount *account, NSError *error))completion;
      
- (void) deleteAccount:(NSString*)id onComplete:(void(^)(BOOL success, NSError *error))completion;
        
- (void) updateLocation:(NSString*)accountId location:(SCGeneralLocation*)location onComplete:(void(^)(BOOL success, NSError *error))completion;
          
- (void) updateBeacons:(NSString*)accountId beachonList:(NSArray*)beaconList onComplete:(void(^)(BOOL success, NSError *error))completion;

// TODO: compare to GCM function
//- (void) updateAPNS:(NSString*)accountId arg:(id)objectArg onComplete:(void(^)(BOOL success, NSError *error))completion;
  
@end
