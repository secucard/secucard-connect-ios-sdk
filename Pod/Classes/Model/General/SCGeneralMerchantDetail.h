//
//  SCGeneralMerchantDetail.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"


@interface SCGeneralMerchantDetail : SCSecuObject

@property (nonatomic, copy) SCGeneralStore *store;
@property (nonatomic, copy) SCGeneralMerchant *merchant;
@property (nonatomic, copy) NSArray *news;
@property (nonatomic, copy) NSNumber *balance;
@property (nonatomic, copy) NSNumber *points;

@end
