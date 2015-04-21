//
//  SCAuthTokenNew.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCAuthTokenNew : SCBaseModel

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSNumber *expiresIn;
@property (nonatomic, copy) NSString *tokenType;
@property (nonatomic, copy) NSString *scope;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSNumber *expireTime;
@property (nonatomic, copy) NSNumber *origExpireTime;

@end
