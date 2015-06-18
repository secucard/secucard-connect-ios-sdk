//
//  SCPaymentSecupayPrepay.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentTransaction.h"

#import "SCPaymentTransferAccount.h"

@interface SCPaymentSecupayPrepay : SCPaymentTransaction

@property (nonatomic, copy) NSString *transferPurpose;
@property (nonatomic, copy) SCPaymentTransferAccount *transferAccount;

@end
