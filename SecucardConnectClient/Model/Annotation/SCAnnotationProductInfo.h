//
//  SCAnnotationProductInfo.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCAnnotationProductInfo : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *resourceId;

@end
