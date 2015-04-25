//
//  SCSmartCheckin.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCMediaResource.h"
#import "SCLoyaltyCustomer.h"
#import "SCGeneralAccount.h"

@interface SCSmartCheckin : MTLModel

@property (nonatomic, copy) NSString *customerName;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) SCMediaResource *pictureObject;
@property (nonatomic, copy) NSDate *created;
@property (nonatomic, copy) SCGeneralAccount *account;
@property (nonatomic, copy) SCLoyaltyCustomer *customer;

@end
