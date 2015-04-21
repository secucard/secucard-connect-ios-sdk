//
//  SCTransportMessage.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCTransportStatus.h"

@interface SCTransportMessage : SCTransportStatus

@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, copy) SCQueryParams *query;
@property (nonatomic, copy) id data;

@end