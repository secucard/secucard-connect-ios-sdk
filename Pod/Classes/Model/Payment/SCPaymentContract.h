//
//  SCPaymentContract.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

@interface SCPaymentContract : SCSecuObject

@property (nonatomic, copy) NSString *contractId;
@property (nonatomic, copy) SCGeneralMerchant *merchant;
@property (nonatomic, copy) NSString *internalReference;
@property (nonatomic, copy) NSDate *created;

@end
