//
//  SCAuthDeviceAuthCode.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCAuthDeviceAuthCode : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *deviceCode;
@property (nonatomic, copy) NSString *userCode;
@property (nonatomic, copy) NSString *verificationUrl;
@property (nonatomic, copy) NSNumber *expiresIn;
@property (nonatomic, copy) NSNumber *interval;

@end
