//
//  SCSmartReceiptLine.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCSmartReceiptLine : MTLModel

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *value;

@end
