//
//  SCServicesIdentResult.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCServicesIdentRequest.h"
#import "SCServicesContract.h"

@interface SCServicesIdentResult : SCSecuObject

@property (nonatomic, copy) SCServicesIdentRequest *request;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSArray *persons;
@property (nonatomic, copy) NSDate *created;
@property (nonatomic, copy) SCServicesContract *contract;

@end
