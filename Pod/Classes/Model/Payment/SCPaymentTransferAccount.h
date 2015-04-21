//
//  SCPaymentTransferAccount.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCPaymentTransferAccount : SCBaseModel

@property (nonatomic, copy) NSString *accountOwner;
@property (nonatomic, copy) NSString *accountNumber;
@property (nonatomic, copy) NSString *iban;
@property (nonatomic, copy) NSString *bic;
@property (nonatomic, copy) NSString *bankCode;

@end
