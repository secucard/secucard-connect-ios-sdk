//
//  SCGeneralEvent.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#define kTypeProperty @"type"
#define kDataPropterty @"data"
#define kTargetProperty @"target"
#define kObjectPropertyPrefix @"event."

@interface SCGeneralEvent : SCSecuObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *target;
@property (nonatomic, copy) NSDate *created;
@property (nonatomic, copy) id data;

@end
