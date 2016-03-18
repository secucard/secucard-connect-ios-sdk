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
#import "SCAccountManager.h"
#import "SCServiceManager.h"
#import "SCStompConfiguration.h"
#import <Mantle/Mantle.h>

#define kErrorDomainSCStompService                  @"SCSecucardCoreStompService"

#define kStompDestinationPrefix                     @"api:"
#define kAppDestinationPrefix                       @"app:"

#define kStompMethodGet                             @"get:"
#define kStompMethodUpdate                          @"update:"
#define kStompMethodAdd                             @"add:"
#define kStompMethodDelete                          @"delete:"
#define kStompMethodExecute                         @"exec:"

#define kNotificationStompError                     @"notificationStompError"
#define kNotificationStompResult                    @"notificationStompResult"
#define kNotificationStompEvent                     @"notificationStompEvent"

typedef void (^ReceiptHandler)(id responseObject, SecuError *error);

/**
 *  The StompManager
 */
@interface SCStompManager : SCServiceManager <SCServiceManagerProtocol>

/**
 *  singleton access
 *
 *  @return the manager's instance
 */
+ (SCStompManager*)sharedManager;

/**
 *  the configuration
 */
@property (nonatomic, retain) SCStompConfiguration *configuration;

/**
 *  flag stating if client is connected
 */
@property (nonatomic, assign) BOOL connected;

/**
 *  init the actual stomp client
 *
 *  @param configuration the stomp configuration
 */
- (void) initWithConfiguration:(SCStompConfiguration*)configuration;

- (void) destroy;

/**
 *  connect to stomp
 */
- (void) connect:(void (^)(bool success, SecuError *error))handler;

- (void) refreshConnection:(void (^)(bool success, SecuError *error))handler;
- (void) sendHeartBeat;
@end
