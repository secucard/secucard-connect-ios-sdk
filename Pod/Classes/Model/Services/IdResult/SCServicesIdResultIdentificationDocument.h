//
//  SCServicesIdResultIdentificationDocument.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCServicesIdResultIdentificationDocument : SCBaseModel

@property (nonatomic, copy) id country;
@property (nonatomic, copy) id dateIssued;
@property (nonatomic, copy) id type;
@property (nonatomic, copy) id validUntil;

@end
