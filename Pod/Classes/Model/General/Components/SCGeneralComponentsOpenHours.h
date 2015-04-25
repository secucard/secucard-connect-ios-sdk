//
//  SCGeneralComponentsOpenHours.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"
#import "SCGeneralComponentsDayTime.h"

@interface SCGeneralComponentsOpenHours : MTLModel

@property (nonatomic, copy) SCGeneralComponentsDayTime *open;
@property (nonatomic, copy) SCGeneralComponentsDayTime *close;

@end
