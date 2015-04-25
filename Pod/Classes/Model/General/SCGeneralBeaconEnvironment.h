//
//  SCGeneralBeaconEnvironment.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCGeneralBeaconEnvironment : MTLModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *proximityUUID;
@property (nonatomic, copy) NSString *macAddress;
@property (nonatomic, copy) NSNumber *major;
@property (nonatomic, copy) NSNumber *minor;
@property (nonatomic, copy) NSNumber *measuredPower;
@property (nonatomic, copy) NSNumber *rssi;
@property (nonatomic, assign) double accuracy;
@property (nonatomic, copy) NSString *proximity;

@end
