//
//  SCLoyaltyMerchantCard.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCGeneralStore.h"
#import "SCLoyaltyCustomer.h"
#import "SCLoyaltyCard.h"
#import "SCLoyaltyCardGroup.h"

@interface SCLoyaltyMerchantCard : SCSecuObject

@property (nonatomic, copy) SCGeneralMerchant *merchant;
@property (nonatomic, copy) SCGeneralMerchant *createdForMerchant;
@property (nonatomic, copy) SCLoyaltyCard *card;
@property (nonatomic, copy) SCGeneralStore *createdForStore;
@property (nonatomic, assign) bool isBaseCard;
@property (nonatomic, copy) SCLoyaltyCardGroup *cardgroup;
@property (nonatomic, copy) SCLoyaltyCustomer *customer;
@property (nonatomic, copy) NSNumber *balance;
@property (nonatomic, copy) NSNumber *points;
@property (nonatomic, copy) NSDate *lastUsage;
@property (nonatomic, copy) NSDate *lastCharge;
@property (nonatomic, copy) NSString *stockStatus;
@property (nonatomic, copy) NSString *lockStatus;
@end
