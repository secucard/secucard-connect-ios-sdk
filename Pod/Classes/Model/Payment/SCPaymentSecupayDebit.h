//
//  SCPaymentSecupayDebit.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentTransaction.h"

#import "SCPaymentContainer.h"

@interface SCPaymentSecupayDebit : SCPaymentTransaction

@property (nonatomic, copy) SCPaymentContainer *container;

@end
