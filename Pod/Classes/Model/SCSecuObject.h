//
//  SCSecuObject.h
//  Pods
//
//  Created by Jörn Schmidt on 13.04.15.
//
//

#import "MTLModel.h"

#define kObjectProperty @"object"
#define kIdProperty @"id"

@interface SCSecuObject : MTLModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *object;

@end
