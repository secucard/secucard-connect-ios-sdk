//
//  SCRestServiceManager.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 02.09.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCAccountManager.h"
#import <AFNetworking/AFNetworking.h>
#import <Reachability/Reachability.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import <PromiseKit/PromiseKit.h>

#define kErrorDomainSCRestService                 @"SCSecucardCoreRestService"

@interface SCRestServiceManager : NSObject

/**
 *  the current refresh token saved to a local var
 */
@property (nonatomic, retain) NSString *currentRefreshToken;

/**
 *  the current access token saved to a local var
 */

@property (nonatomic, retain) NSString *currentAccessToken;

+ (SCRestServiceManager*)sharedManager;

- (void) setupManagerWithApiBaseUrl:(NSString*)baseUrl authBaseUrl:(NSString*)authUrl version:(NSString*)version;

- (PMKPromise*) requestAuthWithParams:(id)params;

- (PMKPromise*) postRequestToEndpoint:(NSString*)endpoint WithParams:(NSDictionary*)params;

- (PMKPromise*) getRequestToEndpoint:(NSString*)endpoint WithParams:(NSDictionary*)params;

- (PMKPromise*) putRequestToEndpoint:(NSString*)endpoint WithParams:(NSDictionary*)params;

- (PMKPromise*) deleteRequestToEndpoint:(NSString*)endpoint WithParams:(NSDictionary*)params;

@end
