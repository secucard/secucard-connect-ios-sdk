//
//  SCGeneralMerchant.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

@class SCGeneralComponentsMetaData;
@class SCGeneralLocation;

@interface SCGeneralMerchant : SCSecuObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) SCGeneralComponentsMetaData *metadata;
@property (nonatomic, copy) SCGeneralLocation *location;
@property (nonatomic, copy) NSArray *photo;
@property (nonatomic, copy) NSString *photoMain;

@end
