//
//  SCStompManager.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 21.08.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCAccountManager.h"
#import <PromiseKit/PromiseKit.h>
#import "SCServiceManager.h"

#define kErrorDomainSCStompService                 @"SCSecucardCoreStompService"

// own definitions
//#define kVirtualHost              @"/"
//#define kReplyQueue               @"/temp-queue/secucard"
//#define kStandardTTL              30
//#define kHeartBeat                @"40000,0"

typedef void (^ConnectCompletion)(NSError *error);

@interface SCStompStorageItem : NSObject

@property (nonatomic, assign) PMKFulfiller fulfill;
@property (nonatomic, assign) PMKRejecter reject;

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
@property (nonatomic, assign)  int port;

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
@property (nonatomic, assign)  int heartbeatMs;

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
@property (nonatomic, assign)  int connectionTimeoutSec;

/**
 *  the socket's timeout in seconds
 */
@property (nonatomic, assign)  int socketTimeoutSec;

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
 *
 *  @return the configuration's insatnce
 */
- (instancetype) initWithHost:(NSString*)host andVHost:(NSString*)virtualHost port:(int)port userId:(NSString*)userId password:(NSString*)password useSSL:(BOOL)useSsl replyQueue:(NSString*)replyQueue connectionTimeoutSec:(int)connectionTimeoutSec socketTimeoutSec:(int)socketTimeoutSec heartbeatMs:(int)heartbeatMs;

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
 *  init the actual stomp client
 *
 *  @param configuration the stomp configuration
 */
- (void) initWithConfiguration:(SCStompConfiguration*)configuration;

/**
 *  connect to stomp
 */
- (PMKPromise*) connect;


@end
