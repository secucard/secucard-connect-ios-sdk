//
//  SCServicesIdentRequest.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCServicesContract.h"

#define kTypePerson @"person"
#define kTypeCompany @"company"

@interface SCServicesIdentRequest : SCSecuObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) SCServicesContract *contract;
@property (nonatomic, copy) NSString *ownerTransactionId;
@property (nonatomic, copy) NSArray *persons;
@property (nonatomic, copy) NSDate *created;

@end
