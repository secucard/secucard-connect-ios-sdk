//
//  SCSmartBasketInfo.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCSmartBasketInfo : MTLModel

@property (nonatomic, copy) NSNumber *sum;
@property (nonatomic, copy) id currency;

@end
