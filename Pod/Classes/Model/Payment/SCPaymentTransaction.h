//
//  SCPaymentTransaction.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#define kStatusAccepted @"accepted"
#define kStatusCancelled @"canceled"
#define kStatusProceed @"proceed"

@interface SCPaymentTransaction : SCSecuObject

@property (nonatomic, copy) SCPaymentCustomer *customer;
@property (nonatomic, copy) SCPaymentContract *contract;
@property (nonatomic, copy) NSNumber *amount;
@property (nonatomic, copy) id currency;
@property (nonatomic, copy) NSString *purpose;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *transId;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *transactionStatus;

@end
