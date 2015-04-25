//
//  SCGeneralComponentsAddressComponent.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCGeneralComponentsAddressComponent : MTLModel

@property (nonatomic, copy) NSString *longName;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, copy) NSArray *types;

@end
