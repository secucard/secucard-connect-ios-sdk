//
//  SCPaymentContainer.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCGeneralMerchant.h"
#import "SCPaymentData.h"
#import "SCPaymentCustomer.h"
#import "SCPaymentContract.h"

#define kTypeBankAccount @"bank_account"

@interface SCPaymentContainer : SCSecuObject

@property (nonatomic, copy) SCGeneralMerchant *merchant;
@property (nonatomic, copy) SCPaymentData *privateData;
@property (nonatomic, copy) SCPaymentData *publicData;
@property (nonatomic, copy) SCPaymentCustomer *assigned;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSDate *created;
@property (nonatomic, copy) NSDate *updated;
@property (nonatomic, copy) SCPaymentContract *contract;

@end
