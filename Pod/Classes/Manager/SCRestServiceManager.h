/******************************************
 *
 *  Copyright (c) 2015. hp.weber GmbH & Co secucard KG (www.secucard.com)
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 ******************************************/

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "SCAccountManager.h"
#import "SCServiceManager.h"
#import "SCRestConfiguration.h"
#import "SecuError.h"

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
- (void) requestAuthWithParams:(id)params completionHandler:(void (^)(id responseObject, SecuError *error))handler;

- (void)execute:(NSString *)appId action:(NSString *)action actionArg:(NSDictionary *)actionArg secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler;

- (void) post:(NSString*)endpoint withAuth:(BOOL)secure withParams:(id)params completionHandler:(void (^)(id responseObject, SecuError *error))handler;

@end
