//
//  SCStompManager.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 21.08.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCAccountManager.h"
#import "SCServiceManager.h"
#import "SCStompConfiguration.h"

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

typedef void (^ReceiptHandler)(id responseObject, NSError *error);

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
- (void) connect:(void (^)(bool success, NSError *error))handler;

- (void) refreshConnection:(void (^)(bool success, NSError *error))handler;

@end
