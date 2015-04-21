//
//  SCGeneralContact.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#define kGenderMale @"MALE"
#define kGenderFemale @"FEMALE"

@interface SCGeneralContact : SCSecuObject

@property (nonatomic, copy) NSString *salutation;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *forename;
@property (nonatomic, copy) NSString *surname;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *nationality;  // ISO 3166 country code like DE
//@property (nonatomic, copy) NSLocale *nationalityLocale = null;
@property (nonatomic, copy) NSDate *dateOfBirth;
@property (nonatomic, copy) NSString *birthPlace;
@property (nonatomic, copy) NSString *companyName;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) SCGeneralAddress *address;
@property (nonatomic, copy) NSString *urlWebsite;
@property (nonatomic, copy) NSString *picture;

@end
