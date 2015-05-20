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
  });
  
  return instance;
}


-(PMKPromise*)updateAccount:(SCGeneralAccount *)account {
  
  return [[self serviceManagerByChannel:RestChannel] updateObject:account];
  
}

- (PMKPromise*)getAccount:(NSString *)accountId {
  
  return [[self serviceManagerByChannel:RestChannel] getObject:[SCGeneralAccount class] objectId:accountId];
  
}

- (PMKPromise*)deleteAccount:(NSString *)accountId {
  
  return [[self serviceManagerByChannel:RestChannel] deleteObject:[SCGeneralAccount class] objectId:accountId];
  
}

-(PMKPromise*)updateLocation:(NSString *)accountId location:(SCGeneralLocation *)location {
  
  return [[self serviceManagerByChannel:StompChannel] updateObject:[SCGeneralAccount class] objectId:accountId action:@"location" actionArg:nil arg:location];
  
}

- (PMKPromise*)createAccount:(SCGeneralAccount *)account {
  
  return [[self serviceManagerByChannel:RestChannel] createObject:account secure:FALSE];
  
}

- (PMKPromise*)updateBeacons:(NSString *)accountId beachonList:(NSArray *)beaconList {
  
  return [[self serviceManagerByChannel:StompChannel] updateObject:[SCGeneralAccount class] objectId:@"me" action:@"beaconEnvironment" actionArg:nil arg:beaconList];
  
}

@end
