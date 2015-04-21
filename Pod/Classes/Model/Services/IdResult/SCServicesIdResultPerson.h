//
//  SCServicesIdResultPerson.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCServicesIdResultPerson : SCBaseModel

@property (nonatomic, copy) SCServicesIdResultIdentificationProcess *identificationProcess;
@property (nonatomic, copy) SCServicesIdResultIdentificationDocument *identificationDocument;
@property (nonatomic, copy) SCServicesIdResultCustomData *customData;
@property (nonatomic, copy) SCServicesIdResultContactData *contactData;
@property (nonatomic, copy) NSArray *attachments;
@property (nonatomic, copy) SCServicesIdResultUserData *userData;

@end
