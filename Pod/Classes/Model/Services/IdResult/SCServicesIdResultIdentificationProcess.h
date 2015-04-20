//
//  SCServicesIdResultIdentificationProcess.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCServicesIdResultIdentificationProcess : MTLModel

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSDate *identificationTime;
@property (nonatomic, copy) NSString *transactionNumber;

@end
