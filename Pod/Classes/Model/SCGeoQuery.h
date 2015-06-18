//
//  SCGeoQuery.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Mantle/Mantle.h>

@interface SCGeoQuery : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *field;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, assign) float lat;
@property (nonatomic, assign) float lon;

@end
