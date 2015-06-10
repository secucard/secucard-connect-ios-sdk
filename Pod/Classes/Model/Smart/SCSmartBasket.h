//
//  SCSmartBasket.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCSmartBasket : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSArray *products;
@property (nonatomic, retain) NSArray *texts;

@end
