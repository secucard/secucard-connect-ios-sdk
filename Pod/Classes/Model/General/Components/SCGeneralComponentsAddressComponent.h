//
//  SCGeneralComponentsAddressComponent.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCBaseModel.h"

@interface SCGeneralComponentsAddressComponent : SCBaseModel

@property (nonatomic, copy) NSString *longName;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, copy) NSArray *types;

@end
