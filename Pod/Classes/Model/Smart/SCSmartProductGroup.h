//
//  SCSmartProductGroup.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCSmartProductGroup : SCBaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSNumber *level;

@end
