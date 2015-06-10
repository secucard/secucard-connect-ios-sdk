//
//  SCServicesIdResultValue.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCServicesIdResultValue : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *original;

@end
