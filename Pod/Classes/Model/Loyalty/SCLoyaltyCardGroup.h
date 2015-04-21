//
//  SCLoyaltyCardGroup.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

@interface SCLoyaltyCardGroup : SCSecuObject

@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *displayNameRaw;
@property (nonatomic, copy) NSNumber *stockWarnLimit;
@property (nonatomic, copy) SCGeneralMerchant *merchant;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) SCMediaResource *pictureObject;

@end
