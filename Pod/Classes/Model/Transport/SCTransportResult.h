//
//  SCTransportResult.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCTransportResult : MTLModel

@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *request;

@end
