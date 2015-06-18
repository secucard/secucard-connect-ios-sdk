//
//  SCStompServiceConfiguration.h
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

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
