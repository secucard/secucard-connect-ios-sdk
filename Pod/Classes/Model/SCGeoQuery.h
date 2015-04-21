//
//  SCGeoQuery.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCBaseModel.h"

@interface SCGeoQuery : SCBaseModel

@property (nonatomic, copy) NSString *field;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, assign) float lat;
@property (nonatomic, assign) float lon;

@end
