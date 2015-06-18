//
//  SCServicesIdResultPerson.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"
#import "SCServicesIdResultIdentificationDocument.h"
#import "SCServicesIdResultIdentificationProcess.h"
#import "SCServicesIdResultCustomData.h"
#import "SCServicesIdResultContactData.h"
#import "SCServicesIdResultUserData.h"

@interface SCServicesIdResultPerson : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) SCServicesIdResultIdentificationProcess *identificationProcess;
@property (nonatomic, copy) SCServicesIdResultIdentificationDocument *identificationDocument;
@property (nonatomic, copy) SCServicesIdResultCustomData *customData;
@property (nonatomic, copy) SCServicesIdResultContactData *contactData;
@property (nonatomic, copy) NSArray *attachments;
@property (nonatomic, copy) SCServicesIdResultUserData *userData;

@end
