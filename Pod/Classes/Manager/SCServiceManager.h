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
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <PromiseKit/PromiseKit.h>

#define kErrorDomainSCService                 @"SCSecucardCoreService"

typedef enum ServiceType
{
  
  ServiceTypeStomp,
  ServiceTypeRest
  
} ServiceType;

@interface SCServiceManager : NSObject

+ (SCServiceManager *)sharedManager;

- (PMKPromise*) makeCall:(SCServiceCallWrapper*)serviceCall withType:(ServiceType)type;

- (PMKPromise*) makeCall:(NSString*)call withMethod:(CallMethod)method params:(id)params pid:(NSString*)pid sid:(NSString*)sid using:(ServiceType)serviceType;

@end
