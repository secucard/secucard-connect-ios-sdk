//
//  SCServicesIdResultAddress.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCServicesIdResultAddress : MTLModel

@property (nonatomic, copy) id postalCode;
@property (nonatomic, copy) id country;
@property (nonatomic, copy) id city;
@property (nonatomic, copy) id street;
@property (nonatomic, copy) id streetNumber;

@end
