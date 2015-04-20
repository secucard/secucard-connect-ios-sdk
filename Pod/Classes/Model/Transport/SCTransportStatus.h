//
//  SCTransportStatus.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCTransportStatus : MTLModel

@property (nonatomic, copy)  NSString *status;
@property (nonatomic, copy)  NSString *error;
@property (nonatomic, copy)  NSString *errorDetails;
@property (nonatomic, copy)  NSString *errorDescription;
@property (nonatomic, copy)  NSString *errorUser;
@property (nonatomic, copy)  NSString *code;
@property (nonatomic, copy)  NSString *supportId;

@end
