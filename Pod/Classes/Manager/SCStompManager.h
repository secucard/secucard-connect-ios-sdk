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
#define kVirtualHost              @"/"
#define kReplyQueue               @"/temp-queue/secucard"
#define kStandardTTL              30
#define kHeartBeat                @"40000,0"

typedef void (^ConnectCompletion)(NSError *error);

@interface SCStompConfiguration : NSObject

@property (nonatomic, retain)  NSString *host;
@property (nonatomic, assign)  int port;
@property (nonatomic, retain)  NSString *password;
@property (nonatomic, retain)  NSString *virtualHost;
@property (nonatomic, assign)  int heartbeatMs;
@property (nonatomic, assign)  BOOL useSsl;
@property (nonatomic, assign)  BOOL autoConnect;
@property (nonatomic, retain)  NSString *userId;
@property (nonatomic, retain)  NSString *replyQueue;
@property (nonatomic, assign)  int connectionTimeoutSec;
@property (nonatomic, assign)  int messageTimeoutSec;
@property (nonatomic, assign)  int maxMessageAgeSec;
@property (nonatomic, assign)  int socketTimeoutSec;
@property (nonatomic, retain)  NSString *basicDestination;

- (instancetype) initWithHost:(NSString*)host andVHost:(NSString*)virtualHost port:(int)port userId:(NSString*)userId password:(NSString*)password useSSL:(BOOL)useSsl replyQueue:(NSString*)replyQueue connectionTimeoutSec:(int)connectionTimeoutSec socketTimeoutSec:(int)socketTimeoutSec heartbeatMs:(int)heartbeatMs;

@end


@interface SCStompManager : SCServiceManager <SCServiceManagerProtocol>

// singleton access
+ (SCStompManager*)sharedManager;

// init the actual stomp client
- (void) initWithConfiguration:(SCStompConfiguration*)configuration;

// simple connection to host
- (PMKPromise*) connect;
//
//// send a message over a queue
//- (PMKPromise*) sendMessage:(id)message toQueue:(NSString*)queue;
//
//// send a message over an exchange
//- (PMKPromise*) sendMessage:(id)message toExchange:(NSString*)exchange;

@end
