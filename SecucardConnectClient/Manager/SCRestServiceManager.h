//
//  SCRestServiceManager.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 02.09.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "SCAccountManager.h"
#import "SCServiceManager.h"
#import "SCRestConfiguration.h"

#define kErrorDomainSCRestService                 @"SCSecucardCoreRestService"


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
 *  @return returns a promise resolveing with nil
 */
- (void) requestAuthWithParams:(id)params completionHandler:(void (^)(id responseObject, NSError *error))handler;

- (void)execute:(NSString *)appId action:(NSString *)action actionArg:(NSDictionary *)actionArg secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler;

- (void) post:(NSString*)endpoint withAuth:(BOOL)secure withParams:(id)params completionHandler:(void (^)(id responseObject, NSError *error))handler;

@end
