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

#define kErrorDomainSCStompService                 @"SCSecucardCoreStompService"

// own definitions
#define kVirtualHost              @"/"
#define kReplyQueue               @"/temp-queue/secucard"
#define kStandardTTL              30
#define kHeartBeat                @"40000,0"

typedef void (^ConnectCompletion)(NSError *error);

@interface SCStompConfiguration : NSObject

@end

@interface SCStompManager : NSObject

// singleton access
+ (SCStompManager*)sharedManager;

// init the actual stomp client
- (void) initWithHost:(NSString*)host port:(NSUInteger)port appId:(NSString*)appId;

// simple connection to host with completion block
- (PMKPromise*) connectToHost:(NSString*)host;

// send a message over a queue
- (PMKPromise*) sendMessage:(id)message toQueue:(NSString*)queue;

// send a message over an exchange
- (PMKPromise*) sendMessage:(id)message toExchange:(NSString*)exchange;

@end
