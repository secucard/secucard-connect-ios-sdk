//
//  SCServicesIdResultUserData.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCServicesIdResultUserData : SCBaseModel

@property (nonatomic, copy) id dateOfBirth;
@property (nonatomic, copy) id forename;
@property (nonatomic, copy) id surname;
@property (nonatomic, copy) SCServicesIdResultAddress *address;
@property (nonatomic, copy) id birthplace;
@property (nonatomic, copy) id nationality;
@property (nonatomic, copy) id gender;

@end
