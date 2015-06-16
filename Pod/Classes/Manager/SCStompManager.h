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

@interface SCStompDestination : NSObject

@property (nonatomic, retain) NSString *command;

@property (nonatomic, retain) NSString *method;

@property (nonatomic, retain) Class type;

@property (nonatomic, retain, readonly) NSString *destination;

+ (instancetype) initWithCommand:(NSString*)command;
+ (instancetype) initWithCommand:(NSString*)command type:(Class)type;
+ (instancetype) initWithCommand:(NSString*)command type:(Class)type method:(NSString*)method;

@end

@interface SCAppDestination : SCStompDestination

@property (nonatomic, retain) NSString *appId;

+ (instancetype) initWithAppId:(NSString *)appId method:(NSString*)method;

@end

@interface SCStompStorageItem : NSObject

@property (nonatomic, copy) ReceiptHandler handler;

@end

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


@end
