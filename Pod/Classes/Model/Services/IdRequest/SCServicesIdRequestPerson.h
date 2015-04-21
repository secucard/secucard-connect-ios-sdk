//
//  SCServicesIdRequestPerson.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCServicesIdRequestPerson : SCBaseModel

@property (nonatomic, copy) NSString *transactionId;
@property (nonatomic, copy) NSString *redirectUrl;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *ownerTransactionId;
@property (nonatomic, copy) NSString *custom1;
@property (nonatomic, copy) NSString *custom2;
@property (nonatomic, copy) NSString *custom3;
@property (nonatomic, copy) NSString *custom4;
@property (nonatomic, copy) NSString *custom5;

@end
