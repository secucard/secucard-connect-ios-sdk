//
//  SCSmartTransaction.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

@interface SCSmartTransaction : SCSecuObject

@property (nonatomic, copy) SCSmartBasketInfo *basketInfo;
@property (nonatomic, copy) SCSmartDevice *deviceSource;
@property (nonatomic, copy) SCSmartDevice *targetDevice;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSDate *created;
@property (nonatomic, copy) NSDate *updated;
@property (nonatomic, copy) NSArray *idents;
@property (nonatomic, copy) SCSmartBasket *basket;
@property (nonatomic, copy) NSString *merchantRef;
@property (nonatomic, copy) NSString *transactionRef;
@property (nonatomic, copy) NSString *paymentMethod;
@property (nonatomic, copy) NSArray *receiptLines;
@property (nonatomic, copy) NSString *paymentRequested;
@property (nonatomic, copy) NSString *paymentExecuted;
@property (nonatomic, copy) NSString *error;

@end
