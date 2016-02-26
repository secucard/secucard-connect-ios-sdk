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
#import "SCAuthSession.h"

#import "SCStompStorageItem.h"
#import "SCStompDestination.h"
#import "SCAppDestination.h"

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

@property (nonatomic, retain) NSTimer *heartbeatTimer;

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
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authDidChange) name:kNotificationTokenDidRefresh object:nil];
  
  _configuration = configuration;
  
  self.promiseStore = [NSMutableDictionary new];
  
  // if created already and connected, then disconnect because we initialize only disconnecting
  if (self.client)
    if (self.client.connected)
      [self.client disconnect];
  
  // create the client
  self.client = [[STOMPClient alloc] initWithHost:self.configuration.host
                                             port:self.configuration.port];
  
  
  __block __weak STOMPClient *weak = self.client;
  
  // set the error handler
  self.client.errorHandler = ^(NSError *error) {
    
    [SCLogManager error:[SCLogManager makeErrorWithDescription:error.localizedDescription andDomain:kErrorDomainSCStompService]];
    
    if (error.domain == GCDAsyncSocketErrorDomain) {
      if (error.code == 7) { // Socket closed by remote peer
        weak.connected = false;
      }
    }
  };
  
  [self.client setReceiptHandler:^(STOMPFrame *frame) {
    NSLog(@"RECEIPT_HANDLER CALLED");
  }];
  
}

- (BOOL)connected {
  return _client.connected;
}

- (void) destroy {
  [self close];
  self.configuration = nil;
  self.client = nil;
}


- (void) resolveStoredItem:(NSString*)correlationId withError:(SecuError *)error {
  
  if (correlationId != nil) {
    
    // get resolveer
    SCStompStorageItem *storedItem = (SCStompStorageItem*)[self.promiseStore objectForKey:correlationId];
    storedItem.handler(nil, error);
    
    [self.promiseStore removeObjectForKey:correlationId];
    
  }
  
}

- (void) resolveStoredItem:(NSString*)correlationId withResult:(id)result {
  
  if (correlationId != nil) {
    
    // get resolveer
    SCStompStorageItem *storedItem = (SCStompStorageItem*)[self.promiseStore objectForKey:correlationId];
    storedItem.handler(result, nil);
    
    [self.promiseStore removeObjectForKey:correlationId];
    
  }
  
}

- (BOOL) needsInitialization
{
  return (self.configuration == nil);
}

#pragma mark connection timer

- (void) setConnectionTimer
{
  [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(closeConnection) object:nil];
  [self performSelector:@selector(closeConnection) withObject:nil afterDelay:self.configuration.heartbeatMs+10000];
}

- (void) doSetHeartbeatTimer:(NSTimeInterval) interval {
  [self sendHeartBeat];
}

- (void) closeConnection
{
  
  // disconnect client
  if (self.client.connected)
    [self.client disconnect];
  
  // cancel disconnect requests
  [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(closeConnection) object:nil];
  [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(sendHeartBeat) object:nil];
  
  // resolve earlier messages by correlation id (timouts)
  for (NSString *itemId in self.promiseStore) {
    SCStompStorageItem *item = [self.promiseStore objectForKey:itemId];
    item.handler(nil, [SCLogManager makeErrorWithDescription:@"Stomp request did time out" andDomain:kErrorDomainSCStompService]);
  }
  
}

- (void) extendConnectionTimer
{
  //[self setConnectionTimer];
}

- (void) refreshConnection:(void (^)(bool success, SecuError *error))handler {
  
  [self closeConnection];
  
  [self connect:^(bool success, SecuError *error) {
    handler(success, error);
  }];
  
}

- (void) sendHeartBeat {
  [self execute:[SCAuthSession class] objectId:@"me" action:@"refresh" actionArg:@"" arg:@{@"refresh_interval":@120} completionHandler:^(id responseObject, NSError *error) {
    
  }];
  [self performSelector:@selector(sendHeartBeat) withObject:nil afterDelay:120000];
}


/**
 *  Actually connect to a host. The completion block is called when the connection is fully established e.g. with tls handshake
 *
 *  @param host       the host
 *  @param completion the completion block
 */
- (void) connect:(void (^)(bool, SecuError *))handler
{
  
  // initialized at all?
  if ([self needsInitialization]) {
    handler(false, [SCLogManager makeErrorWithDescription:@"STOMP: manager not initialzed yet" andDomain:kErrorDomainSCStompService]);
    return;
  }
  
  // stomp client does exist?
  if (!self.client) {
    handler(false, [SCLogManager makeErrorWithDescription:@"STOMP: No client exisiting, create one first" andDomain:kErrorDomainSCStompService]);
    return;
  }
  
  // is already connected? Call completion immediately
  if (self.client.connected) {
    [self extendConnectionTimer];
    handler(true, nil);
    return;
  }
  
  [SCLogManager info:@"STOMP: connect"];
  
  [[SCAccountManager sharedManager] token:^(NSString *token, SecuError *error) {
    
    if (error != nil) {
      handler(false, error);
      return;
    }
    
    self.configuration.userId = token;
    self.configuration.password = token;
    
    __weak SCStompManager *weakself = self;
    // connect to the broker
    
    if (self.configuration.useSsl) {
      
      [self.client connectSecureWithTLSOption:nil
       
                                   andHeaders:@{
                                                kHeaderHost:self.configuration.virtualHost,
                                                kHeaderLogin: self.configuration.userId,
                                                kHeaderDestination: self.configuration.basicDestination,
                                                kHeaderPasscode: self.configuration.password,
                                                kHeaderHeartBeat: [NSString stringWithFormat:@"%@%@", [@(self.configuration.heartbeatMs) stringValue], @",0"],
                                                kHeaderAcceptVersion : @"1.2"
                                                }
       
                            completionHandler:^(STOMPFrame *connectedFrame, NSError *error) {
                              
                              if (error) {
                                
                                // revoke token if connection error
                                [weakself.client disconnect:^(NSError *error) {
                                  NSLog(@"really disconnected");
                                }];
                                
                                handler(false, [SCLogManager makeErrorWithDescription:[NSString stringWithFormat:@"connect failed: %@", error.localizedDescription] andDomain:kErrorDomainSCStompService]);
                                
                              } else {
                                
                                // all done, set timer
                                // [weakself setConnectionTimer];
                                
                                [self setMainExchangeSubscription];
                                
                                // and call completion
                                handler(true, nil);
                                
                              }
                              
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
                        [weakself.client disconnect:^(NSError *error) {
                          NSLog(@"really disconnected");
                        }];
                        
                        handler(false, [SCLogManager makeErrorWithDescription:[NSString stringWithFormat:@"connect failed: %@", error.localizedDescription] andDomain:kErrorDomainSCStompService]);
                        
                      } else {
                        
                        // all done, set timer
                        //[weakself setConnectionTimer];
                        
                        [self setMainExchangeSubscription];
                        
                        // and call completion
                        handler(true, nil);
                        
                      }
                      
                    }];
      
      
    }
    
  }];
  
  
}

- (void) setMainExchangeSubscription {
  
  // set the listener
  [[SCAccountManager sharedManager] token:^(NSString *token, NSError *error) {
    
    if (error != nil) {
      [self closeConnection];
      [SCLogManager error:[SCLogManager makeErrorWithDescription:error.localizedDescription andDomain:kErrorDomainSCStompService]];
      return;
    }
    
    //     refresh auth
    [self doSetHeartbeatTimer:120];
    [self execute:[SCAuthSession class] objectId:@"me" action:@"refresh" actionArg:@"" arg:@{@"refresh_interval":@120} completionHandler:^(id responseObject, NSError *error) {
      
    }];
    
    // subscribe to temp queue without telling the server because the server thinks it is already subscribed to.
    [self.client subscribeToWithoutRegistration:self.configuration.replyQueue
                                        headers:@{
                                                  @"id": self.configuration.replyQueue,
                                                  @"user-id": token,
                                                  @"app-id": self.configuration.userId
                                                  }
                                 messageHandler:^(STOMPMessage *message) {
                                   
                                   NSString *correlationId = [message.headers objectForKey:@"correlation-id"];
                                   
                                   [self extendConnectionTimer];
                                   
                                   // make the body a dictionary
                                   NSError *error = nil;
                                   NSDictionary *body = [NSJSONSerialization JSONObjectWithData: [message.body dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
                                   
                                   // check if parsing error
                                   if (error)
                                   {
                                     [self resolveStoredItem:correlationId withError:[SecuError withError:error]];
                                     return;
                                   }
                                   
                                   if (!correlationId) { // check if event
                                     
                                     if ([[body objectForKey:@"object"] isEqualToString:@"event.pushs"]) {
                                       
                                       // try to parse
                                       NSError *objectParsingError = nil;
                                       SCGeneralEvent *event = [MTLJSONAdapter modelOfClass:[SCGeneralEvent class] fromJSONDictionary:body error:&objectParsingError];
                                       if (objectParsingError) {
                                         [SCLogManager error:[SecuError withError:objectParsingError]];
                                       }
                                       
                                       // send to registered instances
                                       [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationStompEvent object:nil userInfo:@{@"event":event}];
                                       
                                     } else {
                                       
                                       [SCLogManager errorWithDescription:@"Error: unknown push messege type"];
                                       
                                     }
                                     
                                     
                                   } else {
                                     
                                     // check if error from server
                                     if ([[body objectForKey:@"status"] isEqualToString:@"error"])
                                     {
                                       
                                       [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationStompError object:nil userInfo:@{@"message": message.body}];
                                       
                                       NSError *jsonError;
                                       NSData *objectData = [message.body dataUsingEncoding:NSUTF8StringEncoding];
                                       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                                                            options:NSJSONReadingMutableContainers
                                                                                              error:&jsonError];
                                       
                                       if (!jsonError) {
                                         
                                         SecuError* secuError = [SecuError withDictionary:json];
                                         [self resolveStoredItem:correlationId withError:secuError];
                                         
                                       }
                                       
                                       return;
                                       
                                     }
                                     
                                     [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationStompResult object:nil userInfo:@{@"message": message.body}];
                                     
                                     id resultObject = [body objectForKey:@"data"];
                                     
                                     [self resolveStoredItem:correlationId withResult:resultObject];
                                     
                                   }
                                   
                                 }];
    
  }];
  
}

/**
 *  Send a message via established StompClient
 *
 *  @param message the message to be sent
 *  @param queue   the queue to put the message on
 */
- (void) sendMessage:(SCTransportMessage*)message toDestination:(SCStompDestination*)destination completionHandler:(ReceiptHandler)handler
{
  
  [self connect:^(bool success, NSError *error) {
    
    NSString *correlationId = [NSString stringWithFormat:@"%d", [self getNextCorrelationID]];
    
    NSDictionary *messageDict = [self createDic:message];
    if (messageDict == nil) {
      handler(nil, [SCLogManager makeErrorWithDescription:@"could not strip null values from dictionary"]);
      return;
    }
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDict options:0 error:&parseError];
    
    if (parseError) {
      [SCLogManager error:[SCLogManager makeErrorWithDescription:parseError.localizedDescription andDomain:kErrorDomainSCStompService]];
      return;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [[SCAccountManager sharedManager] token:^(NSString *token, NSError *error) {
      
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
      
      SCStompStorageItem *itemToStore = [[SCStompStorageItem alloc] initWithHandler:handler];
      
      [self.promiseStore setObject:itemToStore forKey:[NSString stringWithFormat:@"%@", correlationId]];
      
    }];
    
  }];
  
}

/**
 *  generate the next correlation id (increment)
 *
 *  @return the next correlation id
 */
- (int) getNextCorrelationID {
  return self.currentCorrelationID++;
}

- (void) authDidChange {
  
  // TODO: What todo if
  
  //  [self closeConnection];
  //  [self connect:^(bool success, NSError *error) {
  //
  //    if (error) {
  //      [SCLogManager error:error];
  //    } else if (success) {
  //      [SCLogManager info:@"STOMP: Did reconnect after auth change"];
  //    } else {
  //      [SCLogManager errorWithDescription:@"STOMP: Did not reconnect after auth change"];
  //    }
  //
  //  }];
  
}

#pragma mark - SCServiceManagerProtocol

- (void) open:(void (^)(bool, SecuError *))handler {
  [self connect:handler];
}

- (void) getObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(id, SecuError *))handler {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.data = objectId;
  
  [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodGet type:type] completionHandler:handler];
  
}

- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *, SecuError *))handler {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.query = queryParams;
  
  
  // TODO: Callback if false?
  
  [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodGet type:type] completionHandler:^(id responseObject, SecuError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    SCObjectList *objectList = [MTLJSONAdapter modelOfClass:[SCObjectList class] fromJSONDictionary:responseObject error:&parsingError];
    
    handler(objectList, [SecuError withError:parsingError]);
    
  }];
  
}

- (void) createObject:(SCSecuObject*)object completionHandler:(void (^)(id, SecuError *))handler {
  
  SCTransportMessage *message = [SCTransportMessage new];
  
  NSError *parsingError = nil;
  message.data = [MTLJSONAdapter JSONDictionaryFromModel:object error:&parsingError];
  
  if (parsingError != nil) {
    handler(nil, [SecuError withError:parsingError]);
  }
  
  [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodAdd type:[object class]]completionHandler:^(id responseObject, SecuError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    responseObject = [MTLJSONAdapter modelOfClass:[object class] fromJSONDictionary:responseObject error:&parsingError];
    
    handler(responseObject, [SecuError withError:parsingError]);
    
  }];
  
}

- (void) updateObject:(SCSecuObject*)object completionHandler:(void (^)(SCSecuObject *, SecuError *))handler {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.pid = object.id;
  
  NSError *parsingError = nil;
  message.data = [MTLJSONAdapter JSONDictionaryFromModel:object error:&parsingError];
  
  if (parsingError != nil) {
    handler(nil, [SecuError withError:parsingError]);
  }
  
  [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodUpdate type:[object class]] completionHandler:^(id responseObject, SecuError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    responseObject = [MTLJSONAdapter modelOfClass:[object class] fromJSONDictionary:responseObject error:&parsingError];
    
    handler(responseObject, [SecuError withError:parsingError]);
    
    
  }];
  
}

- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, SecuError *))handler {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.pid = objectId;
  message.sid = actionArg;
  
  if (arg != nil) {
    NSError *parsingError = nil;
    
    if ([arg isKindOfClass:[NSArray class]]) {
      
      NSMutableArray *convertedArray = [NSMutableArray new];
      for (id item in (NSArray*)arg) {
        [convertedArray addObject:[MTLJSONAdapter JSONDictionaryFromModel:item error:&parsingError]];
        if (parsingError != nil) {
          handler(nil, [SecuError withError:parsingError]);
          return;
        }
      }
      message.data = [NSArray arrayWithArray:convertedArray];
      
    } else {
      message.data = [MTLJSONAdapter JSONDictionaryFromModel:arg error:&parsingError];
    }
    
    if (parsingError != nil) {
      handler(nil, [SecuError withError:parsingError]);
    }
  }
  
  [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodUpdate type:type method:action] completionHandler:^(id responseObject, SecuError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    responseObject = [MTLJSONAdapter modelOfClass:type fromJSONDictionary:responseObject error:&parsingError];
    
    handler(responseObject, [SecuError withError:parsingError]);
    
    
  }];
  
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(bool, SecuError *))handler {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.pid = objectId;
  
  [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodDelete type:type] completionHandler:^(id responseObject, SecuError *error) {
    handler((error == nil), error);
  }];
  
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg completionHandler:(void (^)(bool, SecuError *))handler {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.pid = objectId;
  message.sid = actionArg;
  
  [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodDelete type:type method:action] completionHandler:^(id responseObject, SecuError *error) {
    handler((error == nil), error);
  }];
  
}

- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, SecuError *))handler {
  
  SCTransportMessage *message = [SCTransportMessage new];
  message.pid = objectId;
  message.sid = actionArg;
  
  if (arg != nil) {
    
    if ([arg isKindOfClass:[MTLModel class]]) {
      
      NSError *parsingError = nil;
      message.data = [MTLJSONAdapter JSONDictionaryFromModel:arg error:&parsingError];
      
      if (parsingError != nil) {
        handler(nil, [SecuError withError:parsingError]);
      }
      
    } else {
      message.data = arg;
    }
  }
  
  [self sendMessage:message toDestination:[SCStompDestination initWithCommand:kStompMethodExecute type:type method:action] completionHandler:^(id responseObject, SecuError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    responseObject = [MTLJSONAdapter modelOfClass:type fromJSONDictionary:responseObject error:&parsingError];
    
    handler(responseObject, [SecuError withError:parsingError]);
    
  }];
  
}

- (void) execute:(NSString*)appId action:(NSString*)action actionArg:(SCTransportMessage*)actionArg completionHandler:(void (^)(id, SecuError *))handler {
  
  [self sendMessage:actionArg toDestination:[SCAppDestination initWithAppId:appId method:action] completionHandler:handler];
  
}

- (void) close {
  [self closeConnection];
}

@end
