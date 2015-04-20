//
//  SCGeneralStore.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCGeneralMerchant.h"
#import "SCGeneralComponentsGeometry.h"
#import "SCLoyaltyProgram.h"
#import "SCMediaResource.h"

#define kCheckinStatusDeclinedDistance @"declined_distance"
#define kCheckinStatusDeclinedNotavail @"declined_notavail"
#define kCheckinStatusAvailable @"available"
#define kCheckinStatusCheckedIn @"checked_in"
#define kNewsStatusRead @"read"
#define kNewsStatusUnread @"unread"

@interface SCGeneralStore : SCSecuObject

@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *hashProperty;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nameRaw;
@property (nonatomic, copy) SCGeneralMerchant *merchant;
@property (nonatomic, copy) NSString *newsStatus;
@property (nonatomic, copy) NSArray *news;
@property (nonatomic, assign) BOOL openNow;
@property (nonatomic, copy) NSNumber *openTime;
@property (nonatomic, copy) NSArray *openHours;
@property (nonatomic, copy) SCGeneralComponentsGeometry *geometry;
@property (nonatomic, copy) NSNumber *distance;
@property (nonatomic, copy) NSString *checkInStatus;
@property (nonatomic, copy) NSString *addressFormatted;
@property (nonatomic, copy) NSArray *addressComponents;
@property (nonatomic, copy) NSArray *category;
@property (nonatomic, copy) NSString *categoryMain;
@property (nonatomic, copy) NSString *phoneNumberFormatted;
@property (nonatomic, copy) NSString *urlWebsite;
@property (nonatomic, copy) NSNumber *balance;
@property (nonatomic, copy) NSNumber *poNSNumber;
@property (nonatomic, copy) SCLoyaltyProgram *program;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, copy) NSString *facebookId;
@property (nonatomic, copy) NSArray *pictureUrls;
@property (nonatomic, copy) NSString *logoUrl;
@property (nonatomic, copy) SCMediaResource *logo;
@property (nonatomic, assign) BOOL hasBeacon;

@end
