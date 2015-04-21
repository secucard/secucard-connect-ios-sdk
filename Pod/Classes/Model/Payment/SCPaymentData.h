//
//  SCPaymentData.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCPaymentData : SCBaseModel

@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSString *iban;
@property (nonatomic, copy) NSString *bic;

@end
