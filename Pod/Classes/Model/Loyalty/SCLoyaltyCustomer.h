//
//  SCLoyaltyCustomer.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCGeneralMerchant.h"
#import "SCGeneralContact.h"
#import "SCMediaResource.h"

@interface SCLoyaltyCustomer : SCSecuObject

@property (nonatomic, copy) SCGeneralMerchant *merchant;
@property (nonatomic, copy) NSString *foreName;
@property (nonatomic, copy) NSString *surName;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *salutation;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *zipcode;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *fax;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *daysUntilBirthday;
@property (nonatomic, copy) NSArray *additionalData;
@property (nonatomic, copy) NSString *customerNumber;
@property (nonatomic, copy) NSDate *dateOfBirth;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) SCMediaResource *pictureObject;
@property (nonatomic, copy) SCGeneralContact *contact;

@end
