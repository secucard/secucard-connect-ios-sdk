//
//  SCServicesIdResultIdentificationDocument.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCServicesIdResultIdentificationDocument : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) id country;
@property (nonatomic, copy) id dateIssued;
@property (nonatomic, copy) id type;
@property (nonatomic, copy) id validUntil;

@end
