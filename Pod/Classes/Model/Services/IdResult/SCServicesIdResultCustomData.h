//
//  SCServicesIdResultCustomData.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCServicesIdResultCustomData : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *custom1;
@property (nonatomic, copy) NSString *custom2;
@property (nonatomic, copy) NSString *custom3;
@property (nonatomic, copy) NSString *custom4;
@property (nonatomic, copy) NSString *custom5;

@end
