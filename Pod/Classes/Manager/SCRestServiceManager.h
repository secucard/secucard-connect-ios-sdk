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
#import <PromiseKit/PromiseKit.h>
#import "SCServiceManager.h"

#define kErrorDomainSCRestService                 @"SCSecucardCoreRestService"

 /**
 *  The RestConfiguration holds all needed data to connect appropriately to the API via Rest Calls
 */
@interface SCRestConfiguration : NSObject

/**
 *  The base URL to the api
 */
@property (nonatomic, retain, readonly) NSString *baseUrl;

/**
 *  the auth url which is different as it is not secured with token
 */
@property (nonatomic, retain, readonly) NSString *authUrl;

/**
 *  instantiation
 *
 *  @param baseUrl the base url to the api
 *  @param authUrl the authentiaction bas url
 *
 *  @return the configuration instance
 */
- (instancetype) initWithBaseUrl:(NSString*)baseUrl andAuthUrl:(NSString*)authUrl;

@end

/**
 *  The RestServiceManager is a channel to connect to the secucard api in a standardized way as it conforms to the ServiceManager's protocol.
 *  The RestServiceManager is also used to retrieve the auth token before being able to connect to stomp
 */
@interface SCRestServiceManager : SCServiceManager

/**
 *  the current refresh token saved to a local var
 */
@property (nonatomic, retain) NSString *currentRefreshToken;

/**
 *  the current access token saved to a local var
 */

@property (nonatomic, retain) NSString *currentAccessToken;

/**
 *  retrieve the manager's instance
 *
 *  @return the manager's instance as singleton
 */
+ (SCRestServiceManager*)sharedManager;

/**
 *  initializes the manager with the services configuration
 *
 *  @param configuration the configuration
 */
- (void) initWithConfiguration:(SCRestConfiguration*)configuration;

- (void) destroy;

/**
 *  requests for authentication
 *
 *  @param params the auth parameters
 *
 *  @return returns a promise fulfilling with nil
 */
- (PMKPromise*) requestAuthWithParams:(id)params;

- (PMKPromise*) execute:(NSString*)appId command:(NSString*)command arg:(NSDictionary*)arg;

- (PMKPromise*) post:(NSString*)endpoint withAuth:(BOOL)secure withParams:(id)params;

@end
