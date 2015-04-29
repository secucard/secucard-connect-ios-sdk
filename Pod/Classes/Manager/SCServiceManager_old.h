//
//  SCServiceManager.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 06.11.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCRestServiceManager.h"
#import "SCServiceCallWrapper.h"
#import "SCStompManager.h"
#import "SCGlobals.h"
#import <PromiseKit/PromiseKit.h>
#import "SCClientConfiguration.h"

#define kErrorDomainSCService                 @"SCSecucardCoreService"

@interface SCServiceManager_old : NSObject

+ (SCServiceManager_old *)sharedManager;

//- (PMKPromise*) makeCall:(SCServiceCallWrapper*)serviceCall withChannel:(ServiceChannel)channel;
//
//- (PMKPromise*) makeCall:(NSString*)call withMethod:(CallMethod)method params:(id)params pid:(NSString*)pid sid:(NSString*)sid using:(ServiceChannel)channel;

@end
