//
//  SCStompManager.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 21.08.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCStompManager.h"
#import "StompKit.h"
#import "SCServiceEventObject.h"

@interface SCStompManager()

/**
 *  the actual stomp client used by this manager
 */
@property (nonatomic, retain) STOMPClient *client;

/**
 *  The host stomp is reachable at
 */
@property (nonatomic, retain) NSString *stompHost;

/**
 *  The port stomp is reachable at typically 61613 or 61614 for tls
 */
@property (nonatomic, assign) NSUInteger stompPort;

/**
 *  The app Id used for stomp connections
 */
@property (nonatomic, retain) NSString *stompAppId;

/**
 *  the correlation id
 */
@property (nonatomic, assign) int currentCorrelationID;

/**
 *  the timer to close the connection
 */
@property (nonatomic, retain) NSTimer *connectionTimer;


@property (nonatomic, retain) NSMutableDictionary *promiseStore;

@end

@implementation SCStompManager


/**
 *  Shared manager as singleton
 *
 *  @return the manager instance
 */
+ (SCStompManager *)sharedManager
{
  static SCStompManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCStompManager new];
  });
  
  return instance;
}

/**
 *  Initialize the manager with the appropriate configuration.
 *
 *  @param host  the stomp host
 *  @param port  the port for stomp
 *  @param appId the app id for stomp
 */
- (void) initWithHost:(NSString*)host port:(NSUInteger)port appId:(NSString*)appId
{
  
  self.stompHost = host;
  self.stompPort = port;
  self.stompAppId = appId;
  
  // if created already and connected > disconnect
  if (self.client)
    if (self.client.connected)
      [self.client disconnect];
  
  // create the client
  self.client = [[STOMPClient alloc] initWithHost:self.stompHost
                                             port:self.stompPort];
  
  
  // set the errot handler
  
  self.client.errorHandler = ^(NSError *error) {
    
    DDLogError(@"STOMP: BASIC ERROR HANDLER: %@", error);
    
    //    [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"STOMP: BASIC ERROR HANDLER: %@", error]];
    
  };
  
  // set the receipt handler
  __block SCStompManager *weakSelf = self;
  [self.client setReceiptHandler:^(STOMPFrame *frame) {
    
    // always get token before temp queue is subscribed to
    [[SCAccountManager sharedManager] token].then(^(NSString *token) {
      
      // subscribe to temp queue without telling the server because the server thinks it is already subscribed to.
      [weakSelf.client subscribeToWithoutRegistration:kReplyQueue
                                              headers:@{
                                                        @"id": kReplyQueue,
                                                        @"user-id": token,
                                                        @"app-id": weakSelf.stompAppId
                                                        }
                                       messageHandler:^(STOMPMessage *message) {
                                         
                                         NSString *correlationId = [message.headers objectForKey:@"correlation-id"];
                                         
                                         NSString *messageId = [message.headers objectForKey:@"message-id"];
                                         
                                         // TODO: [SCNotificationManager sendNotificationToDisplay:@"STOMP: got message"];
                                         
                                         [weakSelf extendConnectionTimer];
                                         
                                         NSError *error = [NSError new];
                                         NSDictionary *body = [NSJSONSerialization JSONObjectWithData: [message.body dataUsingEncoding:NSUTF8StringEncoding]
                                                                                              options: NSJSONReadingMutableContainers
                                                                                                error: &error];

                                         // check if parsing error
                                         if (error)
                                         {
                                           // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"STOMP: ERROR parsing response: %@", error.userInfo]];
                                           [weakSelf closeConnection];
                                           return;
                                         }
                                         
                                         // check if error from server
                                         if ([[body objectForKey:@"status"] isEqualToString:@"error"])
                                         {
                                           // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"STOMP: ERROR in response: %@", body]];
                                           [weakSelf closeConnection];
                                           
                                           //                                           // error from server means a re-send
                                           //                                           if (correlationId != nil) {
                                           //
                                           //                                             NSString *storedQueue = [[weakSelf.messageStore objectForKey:correlationId] objectForKey:@"queue"];
                                           //
                                           //                                             NSString *storedExchange = [[weakSelf.messageStore objectForKey:correlationId] objectForKey:@"exchange"];
                                           //
                                           //                                             NSString *storedMessage = [[weakSelf.messageStore objectForKey:correlationId] objectForKey:@"message"];
                                           //
                                           //                                             // check if sen dto queue or exchange
                                           //                                             if (storedQueue == nil)
                                           //                                             {
                                           //                                                [weakSelf sendMessage:storedMessage toExchange:storedExchange];
                                           //                                             }
                                           //                                             else
                                           //                                             {
                                           //                                               [weakSelf sendMessage:storedMessage toQueue:storedQueue];
                                           //                                             }
                                           //
                                           //                                             // remove from message store
                                           //
                                           //                                             [weakSelf.messageStore removeObjectForKey:correlationId];
                                           //                                           }
                                           
                                           return;
                                         }
                                         
                                         id resultObject;
                                         
                                         // check if event
                                         if ([body objectForKey:@"type"])
                                         {
                                           if ([[body objectForKey:@"type"] isEqualToString:@"event"])
                                           {
                                             
                                             SCServiceEventObject *event = [SCServiceEventObject initWithDictionary:body];
                                             // TODO: [[SCNotificationManager sharedManager] handleEvent:event];
                                             
                                             resultObject = event.data;
                                             
                                           }
                                         }

                                         if (correlationId != nil) {
                                           
                                           PMKPromiseFulfiller fulfill = (PMKPromiseFulfiller)[weakSelf.promiseStore objectForKey:correlationId];
                                           fulfill(resultObject);
                                           
                                           [weakSelf.promiseStore removeObjectForKey:correlationId];
                                           
                                         }

//                                         NSError * err;
//                                         NSData * jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&err];
//                                         NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//                                         [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"STOMP: Message from STOMP is ok and:\n%@", myString]];
                                         
                                       }];
      
    }).catch(^(NSError *error) {
      
      // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"ERROR - %@ - %@", kErrorDomainSCStompService, error.localizedDescription]];
      
    });
    
  }];
  
}

//- (void) resendStoredMessages {
//  
//  __weak SCStompManager *weakSelf = self;
//  [self.messageStore enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//    [weakSelf resendStoredMessageForId:key];
//  }];
//}
//
//- (void) resendStoredMessageForId:(NSString*)correlationId
//{
//  
//  NSString *storedQueue = [[self.messageStore objectForKey:correlationId] objectForKey:@"queue"];
//  NSString *storedExchange = [[self.messageStore objectForKey:correlationId] objectForKey:@"exchange"];
//  NSString *storedMessage = [[self.messageStore objectForKey:correlationId] objectForKey:@"message"];
//  
//  // check if sen dto queue or exchange
//  if (storedQueue == nil)
//  {
//    [self sendMessage:storedMessage toExchange:storedExchange];
//  }
//  else
//  {
//    [self sendMessage:storedMessage toQueue:storedQueue];
//  }
//  
//  // remove from message store
//  
//  [self.messageStore removeObjectForKey:correlationId];
//  
//}


- (BOOL) needsInitialization
{
  return (self.stompHost == nil ||
          @(self.stompPort) == nil ||
          self.stompAppId == nil);
}

#pragma mark connection timer

- (void) setConnectionTimer
{
  dispatch_async(dispatch_get_main_queue(), ^{
    
    self.connectionTimer = [NSTimer scheduledTimerWithTimeInterval:kStandardTTL target:self selector:@selector(closeConnection) userInfo:nil repeats:YES];
    // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"STOMP: Set unsubscribe timer: %d", kStandardTTL]];
  });
  
}

- (void) closeConnection
{
  
  // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"STOMP: close connection after interval: %d", kStandardTTL]];
  
  if (self.client.connected)
    [self.client disconnect];
  
  [self.connectionTimer invalidate];
  self.connectionTimer = nil;
  
}

- (void) extendConnectionTimer
{
  // invalidate and create new to be sure to extend
  [self.connectionTimer invalidate];
  self.connectionTimer = nil;
  
  [self setConnectionTimer];
}

/**
 *  Actually connect to a host. The completion block is called when the connection is fully established e.g. with tls handshake
 *
 *  @param host       the host
 *  @param completion the completion block
 */
- (PMKPromise*) connectToHost:(NSString*)host
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    // initialized at all?
    if ([self needsInitialization]) {
      reject([SCErrorManager errorWithDescription:@"manager not initialzed yet" andDomain:kErrorDomainSCStompService]);
    }
    
    // stomp client does exist?
    if (!self.client) {
      reject([SCErrorManager errorWithDescription:@"No client exisiting, create one first" andDomain:kErrorDomainSCStompService]);
    }
    
    // is already connected? Call completion immediately
    if (self.client.connected) {
      [self extendConnectionTimer];
      DDLogInfo(@"already connected. Immediate request.");
      //reject([SCErrorManager errorWithDescription:@"already connected. Immediate request." andDomain:kErrorDomainSCStompService]);
      fulfill(nil);
    }
    
    [[SCAccountManager sharedManager] token].then(^(NSString *token) {
      
      __weak SCStompManager *weakself = self;
      // connect to the broker
      [self.client connectSecureWithTLSOption:@{(NSString*)kCFStreamSSLPeerName:self.stompHost}
                                   andHeaders:@{kHeaderHost:host,
                                                kHeaderLogin: token,
                                                kHeaderPasscode: token,
                                                kHeaderHeartBeat: kHeartBeat,
                                                kHeaderAcceptVersion : @"1.2"}
                            completionHandler:^(STOMPFrame *connectedFrame, NSError *error) {
                              
                              if (error) {
                                // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"%@", error]];
                                
                                // revoke token if connection error
                                
                                [weakself.client hardDisconnect];
                                
                                //                                                    [[SCAccountManager sharedManager] logout:^(NSError *error) {
                                //                                                      if (error == nil) {
                                //                                                          [weakself connectToHost:host OnCompletion:completion];
                                //                                                      }
                                //                                                    }];
                                
                                reject([SCErrorManager errorWithDescription:@"connect failed" andDomain:kErrorDomainSCStompService]);
                                
                              }
                              
                              // all done, set timer
                              [weakself setConnectionTimer];
                              
                              // and call completion
                              fulfill(nil);
                              
                            }];

      
    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
    
  }];
  
}

/**
 *  Send a message via established StompClient
 *
 *  @param message the message to be sent
 *  @param queue   the queue to put the message on
 */
- (PMKPromise*) sendMessage:(id)message toQueue:(NSString*)queue
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    [self connectToHost:kVirtualHost].then(^() {
      
      NSError *parseError = [NSError new];
      
      NSData *jsonData = [NSJSONSerialization dataWithJSONObject:message
                                                         options:0
                                                           error:&parseError];
      
      NSString *jsonString = @"";

      if (! jsonData) {
        
        reject([SCErrorManager errorWithDescription:parseError.localizedDescription andDomain:parseError.domain]);
        
      } else {
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
      }
      
      [[SCAccountManager sharedManager] token].then(^(NSString *token) {
        
        int correlationId = [self getNextCorrelationID];
        
        [self.client sendTo:queue
                    headers:@{
                              @"correlation-id":[NSString stringWithFormat:@"%d", correlationId],
                              @"user-id": token,
                              @"app-id": self.stompAppId
                              }
                       body:jsonString];
        
        // add to mesasge store in case of repeated sending
        //      NSDictionary *messageObject = @{
        //                                      @"message": message,
        //                                      @"queue": queue
        //                                      };
        //
        //      [self.messageStore setObject:messageObject forKey:[NSString stringWithFormat:@"%d", correlationId]];
        
        // just fulfill, fire and forget
        fulfill(nil);
        
      }).catch(^(NSError *error) {
        
        reject(error);
        
      });
      
    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
    
  }];
  
}

/**
 *  Send a message over to an exchange, telling it which queue to reply to
 *
 *  @param message    the message to send
 *  @param exchange   the exchange queue
 *  @param replyQueue the reply-to-queue
 */
- (PMKPromise*) sendMessage:(id)message toExchange:(NSString*)exchange
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    [self connectToHost:kVirtualHost].then(^() {
      
      NSError *parseError = [NSError new];
      
      NSData *jsonData = [NSJSONSerialization dataWithJSONObject:message
                                                         options:0
                                                           error:&parseError];
      
      NSString *jsonString = @"";
      
      if (! jsonData) {
        
        reject([SCErrorManager errorWithDescription:parseError.localizedDescription andDomain:parseError.domain]);
        
      } else {
        
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
      }
      
      [[SCAccountManager sharedManager] token].then(^(NSString *token) {
        
        
        int correlationId = [self getNextCorrelationID];
        
        // send to exchange
        [self.client sendTo:exchange
                    headers:@{
                              @"correlation-id":[NSString stringWithFormat:@"%d", correlationId],
                              @"reply-to": @"/temp-queue/secucard",
                              @"receipt": @"secucardReceipt",
                              @"user-id": token,
                              @"app-id": self.stompAppId
                              }
                       body:jsonString];
        
        [self.promiseStore setObject:fulfill forKey:[NSString stringWithFormat:@"%d", correlationId]];
        
      }).catch(^(NSError *error) {
        
        reject(error);
        
      });
      
    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
    
  }];
  
}

/**
 *  generate the next correlation id (increment)
 *
 *  @return the next correlation id
 */
- (int) getNextCorrelationID
{
  return self.currentCorrelationID++;
}

@end
