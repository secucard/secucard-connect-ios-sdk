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
