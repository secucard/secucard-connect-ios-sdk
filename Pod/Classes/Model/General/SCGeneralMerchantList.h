//
//  SCGeneralMerchantList.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCGeneralMerchantList : SCBaseModel

@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSArray *merchants;

@end
