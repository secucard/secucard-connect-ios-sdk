//
//  SCLoyaltyCondition.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

#define kBonusTypePercent @"percent"

@interface SCLoyaltyCondition : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *startValue;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSNumber *bonus;
@property (nonatomic, copy) NSString *bonusType;

@end
