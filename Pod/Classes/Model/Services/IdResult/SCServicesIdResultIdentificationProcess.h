//
//  SCServicesIdResultIdentificationProcess.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCServicesIdResultIdentificationProcess : SCBaseModel

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSDate *identificationTime;
@property (nonatomic, copy) NSString *transactionNumber;

@end
