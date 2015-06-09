//
//  SCMediaResource.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import <Mantle/Mantle.h>

@interface SCMediaResource : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) BOOL isCached;
@property (nonatomic, assign) BOOL cachingEnabled;

- (void) download;

@end
