//
//  SCLoyaltyCondition.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

#define kBonusTypePercent @"percent"

@interface SCLoyaltyCondition : SCBaseModel

@property (nonatomic, copy) NSNumber *startValue;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSNumber *bonus;
@property (nonatomic, copy) NSString *bonusType;

@end
