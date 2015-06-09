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

#define kErrorDomainSCStompService                  @"SCSecucardCoreStompService"

#define kStompDestinationPrefix                     @"api:"
#define kAppDestinationPrefix                       @"app:"

#define kStompMethodGet                             @"get:"
#define kStompMethodUpdate                          @"update:"
#define kStompMethodAdd                             @"add:"
#define kStompMethodDelete                          @"delete:"
#define kStompMethodExecute                         @"exec:"

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
 * The StompConfiguration holds all information to communicate with the secucard infrastructure via stomp in a standardized way
 */
@interface SCStompConfiguration : NSObject

/**
 *  the stomp host
 */
@property (nonatomic, retain)  NSString *host;

/**
 *  the port (tyically 61613 or 61614)
 */
@property (nonatomic, assign)  NSUInteger port;

/**
 *  the password needed to connect the user
 */
@property (nonatomic, retain)  NSString *password;

/**
 *  the virtual host
 */
@property (nonatomic, retain)  NSString *virtualHost;

/**
 *  the stomp heartbeat in milliseconds
 */
@property (nonatomic, assign)  NSUInteger heartbeatMs;

/**
 *  if the service should use ssl
 */
@property (nonatomic, assign)  BOOL useSsl;

/**
 *  the user id to connect
 */
@property (nonatomic, retain)  NSString *userId;

/**
 *  the reply queue's name
 */
@property (nonatomic, retain)  NSString *replyQueue;

/**
 *  the connection timeout in seconds
 */
@property (nonatomic, assign)  NSUInteger connectionTimeoutSec;

/**
 *  the socket's timeout in seconds
 */
@property (nonatomic, assign)  NSUInteger socketTimeoutSec;

/**
 *  the socket's timeout in seconds
 */
@property (nonatomic, retain)  NSString *basicDestination;

/**
 *  instantiates the stomp configuration
 *
 *  @param host                 the stomp host
 *  @param virtualHost          the virtual host
 *  @param port                 the port (tyically 61613 or 61614)
 *  @param userId               the user id to connect
 *  @param password             the password needed to connect the user
 *  @param useSsl               if the service should use ssl
 *  @param replyQueue           the reply queue's name
 *  @param connectionTimeoutSec the connection timeout in seconds
 *  @param socketTimeoutSec     the socket's timeout in seconds
 *  @param heartbeatMs          the stomp heartbeat in milliseconds
 *  @param basicDestination     the server's basic destination
 *
 *  @return the configuration's insatnce
 */
- (instancetype) initWithHost:(NSString*)host andVHost:(NSString*)virtualHost port:(int)port userId:(NSString*)userId password:(NSString*)password useSSL:(BOOL)useSsl replyQueue:(NSString*)replyQueue connectionTimeoutSec:(int)connectionTimeoutSec socketTimeoutSec:(int)socketTimeoutSec heartbeatMs:(int)heartbeatMs basicDestination:(NSString*)basicDestination;

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
