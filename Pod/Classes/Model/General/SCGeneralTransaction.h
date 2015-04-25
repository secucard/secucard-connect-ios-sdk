//
//  SCGeneralTransaction.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCGeneralMerchant.h"
#import "SCLoyaltySale.h"

#define kTypeSale @"sale"
#define kTypeCharge @"charge"

@interface SCGeneralTransaction : SCSecuObject

@property (nonatomic, copy) SCGeneralMerchant *merchant;
@property (nonatomic, copy) NSNumber *amount;
@property (nonatomic, copy) NSDate *lastChange;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) SCLoyaltySale *details;
@property (nonatomic, copy) id currency;

@end
