//
//  SCGeneralComponentsDayTime.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCGeneralComponentsDayTime : MTLModel <MTLJSONSerializing>

@property (nonatomic, retain) NSNumber *day;
@property (nonatomic, retain) NSString *time;

@end
