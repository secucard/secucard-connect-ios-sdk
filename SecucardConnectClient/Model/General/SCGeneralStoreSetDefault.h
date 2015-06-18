//
//  SCGeneralStoreSetDefault.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCGeneralStoreSetDefault : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *reason;
@end
