//
//  SCLoyaltyProgram.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

@interface SCLoyaltyProgram : SCSecuObject

@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) SCLoyaltyCardGroup *cardGroup;
@property (nonatomic, copy) NSArray *conditions;

@end
