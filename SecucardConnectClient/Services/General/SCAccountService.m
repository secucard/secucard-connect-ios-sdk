//
//  SCAccountService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAccountService.h"
#import "SCClientConfiguration.h"

@implementation SCAccountService

/**
 *  get instance of service
 *
 *  @return the singleton instance
 */
+ (SCAccountService*)sharedService
{
  static SCAccountService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    
    instance = [SCAccountService new];
    instance.registeredEventClasses = @[[SCGeneralAccount class]];
    
  });
  
  return instance;
}


- (void) updateAccount:(SCGeneralAccount*)account completionHandler:(void (^)(SCGeneralAccount *, NSError *))handler {
  
  [[self serviceManagerByChannel:OnDemandChannel] updateObject:account completionHandler:^(SCSecuObject *responseObject, NSError *error) {
    
    if ([responseObject isKindOfClass:[SCSecuObject class]]) {
      
      handler((SCGeneralAccount*)responseObject, error);
    } else {
      handler(nil, error);
    }
    
    
  }];
  
}

- (void) getAccount:(NSString*)accountId completionHandler:(void (^)(SCGeneralAccount *, NSError *))handler {
  
  [[self serviceManagerByChannel:OnDemandChannel] getObject:[SCGeneralAccount class] objectId:accountId completionHandler:handler];
  
}

- (void) deleteAccount:(NSString*)accountId completionHandler:(void (^)(bool, NSError *))handler {
  
  [[self serviceManagerByChannel:OnDemandChannel] deleteObject:[SCGeneralAccount class] objectId:accountId completionHandler:handler];
  
}

- (void) updateLocation:(NSString*)accountId location:(SCGeneralLocation*)location completionHandler:(void (^)(bool, NSError *))handler {
  
  [[self serviceManagerByChannel:PersistentChannel] updateObject:[SCGeneralAccount class] objectId:accountId action:@"location" actionArg:nil arg:location completionHandler:^(id responseObject, NSError *error) {
    
    handler((error == nil), error);
    
  }];
  
}

- (void) createAccount:(SCGeneralAccount*)account completionHandler:(void (^)(SCGeneralAccount *, NSError *))handler {
  
  [[self serviceManagerByChannel:OnDemandChannel] createObject:account secure:FALSE completionHandler:handler];
  
}

- (void) updateBeacons:(NSString*)accountId beachonList:(NSArray*)beaconList completionHandler:(void (^)(bool, NSError *))handler; {
  
  return [[self serviceManagerByChannel:PersistentChannel] updateObject:[SCGeneralAccount class] objectId:@"me" action:@"beaconEnvironment" actionArg:nil arg:beaconList completionHandler:^(id responseObject, NSError *error) {
    
    handler((error == nil), error);
    
  }];
  
}

@end
