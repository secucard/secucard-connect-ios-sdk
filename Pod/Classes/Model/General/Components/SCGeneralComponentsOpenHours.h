//
//  SCGeneralComponentsOpenHours.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCGeneralComponentsOpenHours : SCBaseModel

@property (nonatomic, copy) SCGeneralComponentsDayTime *open;
@property (nonatomic, copy) SCGeneralComponentsDayTime *close;

@end
