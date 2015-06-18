//
//  SCSmartText.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCSmartText : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *desc;

@end
