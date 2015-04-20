//
//  SCLoyaltyBonus.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCLoyaltyBonus : MTLModel

@property (nonatomic, copy) NSNumber *amount;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSNumber *balance;

@end
