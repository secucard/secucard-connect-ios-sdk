//
//  SCSmartCheckin.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

@interface SCSmartCheckin : SCBaseModel

@property (nonatomic, copy) NSString *customerName;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) SCMediaResource *pictureObject;
@property (nonatomic, copy) NSDate *created;
@property (nonatomic, copy) SCGeneralAccount *account;
@property (nonatomic, copy) SCLoyaltyCustomer *customer;

@end
