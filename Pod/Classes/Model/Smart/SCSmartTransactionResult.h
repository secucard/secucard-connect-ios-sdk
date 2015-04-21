//
//  SCSmartTransactionResult.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCTransportStatus.h"

@interface SCSmartTransactionResult : SCTransportStatus

@property (nonatomic, copy) SCSmartTransaction *transaction;
@property (nonatomic, copy) NSString *paymentMethod;
@property (nonatomic, copy) NSArray *receiptLines;

@end
