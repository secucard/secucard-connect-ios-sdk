//
//  SCGeneralMerchantList.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCGeneralMerchantList : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSArray *merchants;

@end
