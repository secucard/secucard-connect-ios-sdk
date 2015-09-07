//
//  SCTransportMessage.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"
#import "SCTransportStatus.h"
#import "SCQueryParams.h"

@interface SCTransportMessage : SCTransportStatus <MTLJSONSerializing>

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) SCQueryParams *query;
@property (nonatomic, copy) id data;

@end
