//
//  SCSmartProduct.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

@interface SCSmartProduct : SCSecuObject

@property (nonatomic, copy) NSNumber *productId;
@property (nonatomic, copy) NSNumber *parent;
@property (nonatomic, copy) NSString *articleNumber;
@property (nonatomic, copy) NSString *ean;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSNumber *quantity;
@property (nonatomic, copy) NSNumber *priceOne;
@property (nonatomic, copy) NSNumber *tax;
@property (nonatomic, copy) NSArray *groups;

@end
