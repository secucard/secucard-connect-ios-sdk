//
//  SCLoyaltyProgram.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

@class SCLoyaltyCardGroup;

@interface SCLoyaltyProgram : SCSecuObject

@property (nonatomic, copy) NSString *descriptionText;
@property (nonatomic, copy) SCLoyaltyCardGroup *cardGroup;
@property (nonatomic, copy) NSArray *conditions;

@end
