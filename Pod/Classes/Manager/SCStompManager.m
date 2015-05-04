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
#import "SCTransportMessage.h"

@implementation SCStompDestination

- (NSString *)destination {
  
  NSString *dest = [NSString stringWithFormat:@"%@%@", [SCStompManager sharedManager].configuration.basicDestination, kStompDestinationPrefix];
  
  dest = [dest stringByAppendingString:self.command];
  
  
  if (self.type) {
    dest = [dest stringByAppendingString:[[self.type object] lowercaseString]];                 // -> general.publicmerchants
  }
  
  if (self.method) {
    dest = [dest stringByAppendingString:@"."];
    dest = [dest stringByAppendingString:self.method];
  }
  
  return dest;
  
}

+ (instancetype) initWithCommand:(NSString*)command {
  return [self initWithCommand:command type:nil method:nil];
}

+ (instancetype) initWithCommand:(NSString*)command type:(Class)type {
  return [self initWithCommand:command type:type method:nil];
}

+ (instancetype) initWithCommand:(NSString*)command type:(Class)type method:(NSString*)method {
  
  SCStompDestination *destination = [SCStompDestination new];
  
  destination.command = command;
  destination.type = type;
  destination.method = method;
  
  return destination;

}

@end

@implementation SCAppDestination

+ (instancetype) initWithAppId:(NSString *)appId method:(NSString*)method {
  
  SCAppDestination *appDest = [SCAppDestination initWithCommand:nil type:nil method:method];
  appDest.appId = appId;
  
  return appDest;
  
}

- (NSString *)destination {
  
  return [NSString stringWithFormat:@"%@%@%@", [SCStompManager sharedManager].configuration.basicDestination, kStompDestinationPrefix, self.method];
  
}

@end

@implementation SCStompStorageItem

@end

@implementation SCStompConfiguration

- (instancetype) initWithHost:(NSString *)host andVHost:(NSString *)virtualHost port:(int)port userId:(NSString *)userId password:(NSString *)password useSSL:(BOOL)useSsl replyQueue:(NSString *)replyQueue connectionTimeoutSec:(int)connectionTimeoutSec socketTimeoutSec:(int)socketTimeoutSec heartbeatMs:(int)heartbeatMs basicDestination:(NSString *)basicDestination {
  
  self = [super init];
  if (self) {
    self.host = host;
    self.virtualHost = virtualHost;
    self.port = port;
    self.userId = userId;
    self.password = password;
    self.useSsl = useSsl;
    self.replyQueue = replyQueue;
    self.connectionTimeoutSec = connectionTimeoutSec;
    self.socketTimeoutSec = socketTimeoutSec;
    self.heartbeatMs = heartbeatMs;
    self.basicDestination = basicDestination;
  }
  return self;
  
}

@end

@interface SCStompManager()

/**
 *  the actual stomp client used by this manager
 */
@property (nonatomic, retain) STOMPClient *client;

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
- (void) initWithConfiguration:(SCStompConfiguration *)configuration
{
  
  _configuration = configuration;
  
  // if created already and connected, then disconnect because we initialize only disconnecting
  if (self.client)
    if (self.client.connected)
      [self.client disconnect];
  
  // create the client
  self.client = [[STOMPClient alloc] initWithHost:self.configuration.host
                                             port:self.configuration.port];
  
  // set the error handler
  self.client.errorHandler = ^(NSError *error) {
    [SCErrorManager handleError:[SCErrorManager errorWithDescription:error.localizedDescription andDomain:kErrorDomainSCStompService]];
  };
  
  // set the receipt handler
  __weak __block SCStompManager *weakSelf = self;
  
  [self.client setReceiptHandler:^(STOMPFrame *frame) {
    
    // always get token before temp queue is subscribed to
    [[SCAccountManager sharedManager] token].then(^(NSString *token) {
      
      // subscribe to temp queue without telling the server because the server thinks it is already subscribed to.
      [weakSelf.client subscribeToWithoutRegistration:weakSelf.configuration.replyQueue
                                              headers:@{
                                                        @"id": weakSelf.configuration.replyQueue,
                                                        @"user-id": token,
                                                        @"app-id": weakSelf.configuration.userId
                                                        }
                                       messageHandler:^(STOMPMessage *message) {
                                         
                                         NSString *correlationId = [message.headers objectForKey:@"correlation-id"];
                                         
                                         //                                         NSString *messageId = [message.headers objectForKey:@"message-id"];
                                         
                                         // TODO: [SCNotificationManager sendNotificationToDisplay:@"STOMP: got message"];
                                         
                                         [weakSelf extendConnectionTimer];
                                         
                                         NSError *error = [NSError new];
                                         NSDictionary *body = [NSJSONSerialization JSONObjectWithData: [message.body dataUsingEncoding:NSUTF8StringEncoding]
                                                                                              options: NSJSONReadingMutableContainers
                                                                                                error: &error];
                                         
                                         // check if parsing error
                                         if (error)
                                         {
                                           [weakSelf rejectStoredItem:correlationId withError:error];
                                           @throw error.localizedDescription;
                                         }
                                         
                                         // check if error from server
                                         if ([[body objectForKey:@"status"] isEqualToString:@"error"])
                                         {
                                           
                                           // TODO: check about resending messages
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

                                           [weakSelf rejectStoredItem:correlationId withError:[SCErrorManager errorWithDescription:@"error in stomp response" andDomain:kErrorDomainSCStompService]];
                                           @throw @"error in stomp response";
                                         }
                                         
                                         id resultObject;
                                         
                                         // check if event
                                         if ([body objectForKey:@"type"])
                                         {
                                           if ([[body objectForKey:@"type"] isEqualToString:@"event"])
                                           {
                                             
                                             SCServiceEventObject *event = [SCServiceEventObject initWithDictionary:body];
                                             resultObject = event.data;
                                             
                                           }
                                         }
                                         
                                         // if we have a correlation id, chance is good, that there is a promise that wants to be fullfilled
                                         [weakSelf fulfillStoredItem:correlationId withResult:resultObject];
                                         
                                       }];
      
    }).catch(^(NSError *error) {
      [weakSelf closeConnection];
      [SCErrorManager handleError:[SCErrorManager errorWithDescription:error.localizedDescription andDomain:kErrorDomainSCStompService]];
    });
    
  }];
  
}

- (void) rejectStoredItem:(NSString*)correlationId withError:(NSError *)error {
  
  if (correlationId != nil) {
    
    // get fulfiller
    SCStompStorageItem *storedItem = (SCStompStorageItem*)[self.promiseStore objectForKey:correlationId];
    storedItem.reject(error);
    
    [self.promiseStore removeObjectForKey:correlationId];
    
  }
  
}

- (void) fulfillStoredItem:(NSString*)correlationId withResult:(id)result {
  
  if (correlationId != nil) {
    
    // get fulfiller
    SCStompStorageItem *storedItem = (SCStompStorageItem*)[self.promiseStore objectForKey:correlationId];
    storedItem.fulfill(result);
    
    [self.promiseStore removeObjectForKey:correlationId];
    
  }
  
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
  return (self.configuration == nil);
}

#pragma mark connection timer

- (void) setConnectionTimer
{
  [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(closeConnection) object:nil];
  [self performSelector:@selector(closeConnection) withObject:nil afterDelay:self.configuration.connectionTimeoutSec];
}

- (PMKPromise*) closeConnection
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    if (self.client.connected)
      [self.client disconnect];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(closeConnection) object:nil];
    
    fulfill(nil);
    
  }];
  
}

- (void) extendConnectionTimer
{
  [self setConnectionTimer];
}

/**
 *  Actually connect to a host. The completion block is called when the connection is fully established e.g. with tls handshake
 *
 *  @param host       the host
 *  @param completion the completion block
 */
- (PMKPromise*) connect
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
      [SCErrorManager handleErrorWithDescription:@"already connected. Immediate request."];
      fulfill(nil);
    }
    
    [[SCAccountManager sharedManager] token].then(^(NSString *token) {
      
      self.configuration.userId = token;
      self.configuration.password = token;
      
      __weak SCStompManager *weakself = self;
      // connect to the broker
      
      if (self.configuration.useSsl) {
        
        [self.client connectSecureWithTLSOption:@{(NSString*)kCFStreamSSLPeerName:self.configuration.virtualHost}
                                     andHeaders:@{kHeaderHost:self.configuration.host,
                                                  kHeaderLogin: self.configuration.userId,
                                                  kHeaderPasscode: self.configuration.password,
                                                  kHeaderHeartBeat: @(self.configuration.heartbeatMs),
                                                  kHeaderAcceptVersion : @"1.2"}
                              completionHandler:^(STOMPFrame *connectedFrame, NSError *error) {
                                
                                if (error) {
                                  
                                  // revoke token if connection error
                                  [weakself.client hardDisconnect];
                                  
                                  // TODO: Need logout?
//                                  [[SCAccountManager sharedManager] logout:^(NSError *error) {
//                                    if (error == nil) {
//                                      [weakself connectToHost:host OnCompletion:completion];
//                                    }
//                                  }];
                                  
                                  reject([SCErrorManager errorWithDescription:@"connect failed" andDomain:kErrorDomainSCStompService]);
                                  
                                }
                                
                                // all done, set timer
                                [weakself setConnectionTimer];
                                
                                // and call completion
                                fulfill(nil);
                                
                              }];
        
      } else {
        
        [self.client connectWithHeaders:@{kHeaderHost:self.configuration.host,
                                          kHeaderLogin: token,
                                          kHeaderPasscode: token,
                                          kHeaderHeartBeat: @(self.configuration.heartbeatMs),
                                          kHeaderAcceptVersion : @"1.2"}
                      completionHandler:^(STOMPFrame *connectedFrame, NSError *error) {
                        
                        if (error) {
                          
                          // revoke token if connection error
                          [weakself.client hardDisconnect];

                          // TODO: Need logout?
//                          [[SCAccountManager sharedManager] logout:^(NSError *error) {
//                            if (error == nil) {
//                              [weakself connectToHost:host OnCompletion:completion];
//                            }
//                          }];
                          
                          reject([SCErrorManager errorWithDescription:@"connect failed" andDomain:kErrorDomainSCStompService]);
                          
                        }
                        
                        // all done, set timer
                        [weakself setConnectionTimer];
                        
                        // and call completion
                        fulfill(nil);
                        
                      }];
        
        
      }
      
    });
    
  }];
  
}

/**
 *  Send a message via established StompClient
 *
 *  @param message the message to be sent
 *  @param queue   the queue to put the message on
 */
- (PMKPromise*) sendMessage:(SCTransportMessage*)message toDestination:(SCStompDestination*)destination
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    [self connect].then(^() {
      
      NSString *correlationId = [NSString stringWithFormat:@"%d", [self getNextCorrelationID]];
      
      NSError *transformationError = [NSError new];
      [MTLJSONAdapter JSONDictionaryFromModel:message error:&transformationError];
      
      if (transformationError) {
        [SCErrorManager handleError:[SCErrorManager errorWithDescription:transformationError.localizedDescription andDomain:kErrorDomainSCStompService]];
        return;
      }
      
      NSError *parseError = [NSError new];
      NSData *jsonData = [NSJSONSerialization dataWithJSONObject:message
                                                         options:0
                                                           error:&parseError];
      
      if (parseError) {
        [SCErrorManager handleError:[SCErrorManager errorWithDescription:parseError.localizedDescription andDomain:kErrorDomainSCStompService]];
        return;
      }
      
      NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
      
      [[SCAccountManager sharedManager] token].then(^(NSString *token) {
        
        NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                       @"correlation-id": correlationId,
                                                                                       @"reply-to": self.configuration.replyQueue,
                                                                                       @"persistent":@"true",
                                                                                       @"user-id": token,
                                                                                       @"app-id": self.configuration.userId
                                                                                       }];
        
        if ([destination isKindOfClass:[SCAppDestination class]]) {
          [headers setObject:((SCAppDestination*)destination).appId forKey:@"app-id"];
        }
        
        [self.client sendTo:destination.destination
                    headers:headers
                       body:jsonString];
        
        SCStompStorageItem *itemToStore = [SCStompStorageItem new];
        itemToStore.fulfill = fulfill;
        itemToStore.reject = reject;
        
        [self.promiseStore setObject:itemToStore forKey:[NSString stringWithFormat:@"%@", correlationId]];
        
      });
      
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

#pragma mark - SCServiceManagerProtocol

- (PMKPromise*) open {
  
  return [self connect];
  
}

- (PMKPromise*) getObject:(Class)type objectId:(NSString*)objectId {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.data = objectId;
  
  return [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodGet type:type]];
  
}

- (PMKPromise*) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.query = queryParams;
  
  // TODO: Callback if false?
  
  return [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodGet type:type]];
  
}

- (PMKPromise*) createObject:(SCSecuObject*)object {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.data = object;
  
  return [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodAdd type:[object class]]];
  
}

- (PMKPromise*) updateObject:(SCSecuObject*)object {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.pid = object.id;
  message.data = object;
  
  return [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodUpdate type:[object class]]];
  
}

- (PMKPromise*) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.pid = objectId;
  message.sid = actionArg;
  message.data = arg;
  
  return [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodUpdate type:type method:action]];
  
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.pid = objectId;
  
  return [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodDelete type:type]];
  
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.pid = objectId;
  message.sid = actionArg;
  
  return [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodDelete type:type method:action]];
  
}

- (PMKPromise*) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg {

  SCTransportMessage *message = [SCTransportMessage new];
  message.pid = objectId;
  message.sid = actionArg;
  message.data = arg;
  
  return [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodExecute type:type method:action]];

}

- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action actionArg:(id)actionArg {

  return [self sendMessage:actionArg toDestination:[SCAppDestination initWithAppId:appId method:action]];
  
}

- (PMKPromise*) close {
  
  return [self closeConnection];
  
}

@end
