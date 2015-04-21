//
//  SCLoyaltySale.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

@interface SCLoyaltySale : SCSecuObject

@property (nonatomic, copy) NSNumber *amount;
@property (nonatomic, copy) NSDate *lastChange;
@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, copy) NSString *descriptionString;
@property (nonatomic, copy) NSString *descriptionRaw;
@property (nonatomic, copy) SCGeneralStore *store;
@property (nonatomic, copy) SCLoyaltyCard *card;
@property (nonatomic, copy) SCLoyaltyCardGroup *cardgroup;
@property (nonatomic, copy) SCLoyaltyMerchantCard *merchantcard;
@property (nonatomic, copy) NSNumber *balanceAmount;
@property (nonatomic, copy) NSNumber *balancePoints;
@property (nonatomic, copy) id currency;
@property (nonatomic, copy) NSArray *bonus;

@end
