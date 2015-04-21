//
//  SCGeneralAssignment.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCGeneralAssignment : SCBaseModel

@property (nonatomic, copy) NSDate *created;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL owner;
@property (nonatomic, copy) MTLModel *assign;

@end
