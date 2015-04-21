//
//  SCPaymentCustomer.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

@interface SCPaymentCustomer : SCSecuObject

@property (nonatomic, copy) SCGeneralMerchant *merchant;
@property (nonatomic, copy) SCPaymentContract *contact;
@property (nonatomic, copy) NSDate *created;
@property (nonatomic, copy) NSDate *updated;
@property (nonatomic, copy) SCPaymentContract *contract;

@end
