//
//  SCGeneralPublicMerchant.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"


@interface SCGeneralPublicMerchant : SCSecuObject

@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *hash;
@property (nonatomic, copy) NSArray *addressComponents;
@property (nonatomic, copy) NSString *addressFormatted;
@property (nonatomic, copy) NSString *phoneNumberFormatted;
@property (nonatomic, copy) SCGeneralComponentsGeometry *geometry;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *photo;
@property (nonatomic, copy) NSString *photoMain;
@property (nonatomic, copy) NSArray *category;
@property (nonatomic, copy) NSString *categoryMain;
@property (nonatomic, copy) NSString *urlGooglePlus;
@property (nonatomic, copy) NSString *urlWebsite;
@property (nonatomic, copy) NSNumber *utcOffset;
@property (nonatomic, assign) BOOL openNow;
@property (nonatomic, copy) NSNumber *openTime;
@property (nonatomic, copy) NSArray *openHours;
@property (nonatomic, copy) NSNumber *distance;
@property (nonatomic, assign) BOOL checkedIn;

@end
