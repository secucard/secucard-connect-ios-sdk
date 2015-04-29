//
//  SCMediaResource.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel.h"

@interface SCMediaResource : MTLModel

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) BOOL isCached;
@property (nonatomic, assign) BOOL cachingEnabled;

@end