//
//  SCLoyaltyBonus.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCLoyaltyBonus : SCBaseModel

@property (nonatomic, copy) NSNumber *amount;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSNumber *balance;

@end
