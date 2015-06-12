//
//  SCRestServiceManager.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 02.09.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//
#import "SCRestServiceManager.h"
#import <Mantle/Mantle.h>
#import "SCSecuObject.h"



@interface SCRestConfiguration()

@property (nonatomic, retain) NSString *baseUrl;
@property (nonatomic, retain) NSString *authUrl;

@end

@implementation SCRestConfiguration

- (instancetype) initWithBaseUrl:(NSString*)baseUrl andAuthUrl:(NSString*)authUrl {
  self = [super init];
  if (self) {
    self.baseUrl = baseUrl;
    self.authUrl = authUrl;
  }
  return self;
  
}

@end

@interface SCRestServiceManager()

@property (nonatomic, retain) SCRestConfiguration *configuration;

@property (nonatomic, retain) AFHTTPRequestOperationManager* authOperationManager;
@property (nonatomic, retain) AFHTTPRequestOperationManager* operationManager;

@end

/**
 *  Thr SCRestServiceManager is responsible for any REST communication with the given server
 */
@implementation SCRestServiceManager

/**
 *  A serializer for any request
 */
AFHTTPRequestSerializer *requestSerializer;
AFHTTPRequestSerializer *authRequestSerializer;

/**
 *  get instance of manager
 *
 *  @return the singleton instance
 */
+ (SCRestServiceManager *)sharedManager
{
  static SCRestServiceManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCRestServiceManager new];
  });
  
  return instance;
}

- (void) initWithConfiguration:(SCRestConfiguration*)configuration {
  
  self.configuration = configuration;
  
  requestSerializer = [AFJSONRequestSerializer serializer];
  [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
  
  if ([SCAccountManager sharedManager].accessToken) {
    [requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", [SCAccountManager sharedManager].accessToken] forHTTPHeaderField:@"Authorization"];
  }
  
  
  self.operationManager = [AFHTTPRequestOperationManager manager];
  self.operationManager.requestSerializer = requestSerializer;
  
  authRequestSerializer = [AFJSONRequestSerializer serializer];
  [authRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  [authRequestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [authRequestSerializer setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
  
  self.authOperationManager = [AFHTTPRequestOperationManager manager];
  self.authOperationManager.requestSerializer = authRequestSerializer;
  
}

- (void) destroy {
  
  [self close];
  self.configuration = nil;
  requestSerializer = nil;
  self.authOperationManager = nil;
  self.operationManager = nil;
  
}

- (void) requestAuthWithParams:(id)params completionHandler:(void (^)(id responseObject, NSError *error))handler
{
  
  // do the actual request
  [self.authOperationManager POST:[NSString stringWithFormat:@"%@%@", self.configuration.authUrl, @"oauth/token"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    [self.operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", responseObject] forHTTPHeaderField:@"Authorization"];
    handler(responseObject, nil);
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    handler(nil, error);
    
  }];
  
}

/**
 *  sends a generic POST-request, generic means that you can choose endpont information and alike on your own
 *
 *  @param endpoint     endpoint url, like General/Skeletons
 *  @param params       the parameters to send
 */
- (void) postRequestToEndpoint:(NSString*)endpoint WithParams:(id)params secure:(BOOL)secure completionHandler:(void (^)(id responseObject, NSError *error))handler
{
  
  if (secure) {
    
    [[SCAccountManager sharedManager] token:^(NSString *token, NSError *error) {
      
      [self.operationManager POST:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        handler(responseObject, nil);
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        handler(nil, [self doBasicErrorHandling:error]);
        
      }];
      
    }];
    
  } else {
    
    [self.authOperationManager POST:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
      handler(responseObject, nil);
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
      handler(nil, [self doBasicErrorHandling:error]);
      
    }];
    
  }
  
}


/**
 *  Send a generic GET-request, generic means that you can choose andpoint and alike on your own
 *
 *  @param endpoint     endpoint URL like General/Skeletons
 *  @param params       the parameters to send
 */
- (void) getRequestToEndpoint:(NSString*)endpoint WithParams:(id)params secure:(BOOL)secure completionHandler:(void (^)(id responseObject, NSError *error))handler
{
  
  if (secure) {
    
    [[SCAccountManager sharedManager] token:^(NSString *token, NSError *error) {
      
      [self.operationManager GET:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        handler(responseObject, nil);
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        handler(nil, [self doBasicErrorHandling:error]);
        
      }];
      
    }];
    
  } else {
    
    [self.authOperationManager GET:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
      handler(responseObject, nil);
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
      handler(nil, [self doBasicErrorHandling:error]);
      
    }];
    
  }
  
}

/**
 *  Send a generic GET-request, generic means that you can choose andpoint and alike on your own
 *
 *  @param endpoint     endpoint URL like General/Skeletons
 *  @param params       the parameters to send
 */
- (void) putRequestToEndpoint:(NSString*)endpoint WithParams:(id)params secure:(BOOL)secure completionHandler:(void (^)(id responseObject, NSError *error))handler
{
  
  if (secure) {
    
    [[SCAccountManager sharedManager] token:^(NSString *token, NSError *error) {
      
      [self.operationManager PUT:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        handler(responseObject, nil);
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        handler(nil, [self doBasicErrorHandling:error]);
        
      }];
      
    }];
    
  } else {
    
    [self.authOperationManager PUT:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
      handler(responseObject, nil);
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
      handler(nil, [self doBasicErrorHandling:error]);
      
    }];
    
  }
  
}

/**
 *  Send a generic GET-request, generic means that you can choose andpoint and alike on your own
 *
 *  @param endpoint     endpoint URL like General/Skeletons
 *  @param params       the parameters to send
 *
 */
- (void) deleteRequestToEndpoint:(NSString*)endpoint WithParams:(NSDictionary*)params secure:(BOOL)secure completionHandler:(void (^)(id responseObject, NSError *error))handler
{
  
  if (secure) {
    
    [[SCAccountManager sharedManager] token:^(NSString *token, NSError *error) {
      
      [self.operationManager DELETE:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        handler(responseObject, nil);
        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        handler(nil, [self doBasicErrorHandling:error]);
        
      }];
      
    }];
    
  } else {
    
    [self.authOperationManager DELETE:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
      
      handler(responseObject, nil);
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
      handler(nil, [self doBasicErrorHandling:error]);
      
    }];
    
  }
  
}

/**
 *  Here we do some basic error handling, not really basic but base
 *
 *  @param error     the NSError
 *  @param operation The opertion the error was raised in
 *
 *  @return the input Error as output
 */
- (NSError*) doBasicErrorHandling:(NSError*)error
{
  
  //possible action by code
  //  switch (error.response.statusCode) {
  //    case 400: // Invalid
  //
  //      break;
  //
  //    case 401: // Unauthorized
  //
  //      break;
  //
  //    case 403: // Forbidden
  //
  //      break;
  //
  //    case 426: // Update required
  //
  //      break;
  //
  //    case 409: // Conflict
  //
  //      break;
  //
  //    case 500: // Internal
  //
  //      break;
  //
  //    default:
  //      break;
  //  }
  
  return error;
}

- (NSString*) resolveEndpoint:(Class)type {
  return [self resolveEndpoint:type args:nil];
}

- (NSString*) resolveEndpoint:(Class)type args:(NSArray*)args {
  
  // check if class is subclass of SCSecuObject
  if (type != nil && ![type isSubclassOfClass:[SCSecuObject class]]) {
    [SCErrorManager handleError:[SCErrorManager errorWithDescription:@"Endpoint resolver: class is no subclass of SCSecuObject and as such, can have no endpoint"]];
    return @"";
  }
  
  
  NSString *callString = (!type) ? @"" : [type object];                                       // -> General.PublicMerchants
  
  callString = [callString stringByReplacingOccurrencesOfString:@"." withString:@"/"];        // -> General/PublicMerchants
  
  if (!args) {
    args = @[];
  }
  
  for (int i = 0; i < args.count; i++) {
    
    if (![args[i] isKindOfClass:[NSString class]]) {
      continue;
    }
    
    callString = [callString stringByAppendingString:[@"/" stringByAppendingString:args[i]]]; // -> General/PublicMerchants/pmc_231234124
    
  }
  
  //  // add ME to Accounts-Path
  //  if (pid != nil)
  //  {
  //    callString = [callString stringByReplacingOccurrencesOfString:@"{pid}/" withString:[NSString stringWithFormat:@"%@/", pid]];
  //  }
  //  else
  //  {
  //    callString = [callString stringByReplacingOccurrencesOfString:@"{pid}/" withString:@""];
  //  }
  //
  //  // add SID if there
  //  if (sid != nil)
  //  {
  //    callString = [callString stringByAppendingString:[NSString stringWithFormat:@"/%@", sid]];
  //  }
  //
  // if not an auth call add api and version to it
  //      if (![callString containsString:@"oauth"])
  //      {
  // combine all
  //c = [NSString stringWithFormat:@"%@%@%@", kAPIPrefix, kAPIVersion, c];
  //      }
  
  return callString;
  
  
}

#pragma mark - SCServiceManagerProtocol

/**
 *  opening the rest channel just resolves instantly
 *
 *  @return promise resolveing instantly
 */
- (void) open:(void (^)(bool success, NSError *error))handler{
  
  handler(true, nil);
  
}

- (void) getObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler {
  
  [self getRequestToEndpoint:[self resolveEndpoint:type args:@[objectId]] WithParams:nil secure:secure completionHandler:^(id responseObject, NSError *error) {
    
    if (error) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    id typedObject = [MTLJSONAdapter modelOfClass:type fromJSONDictionary:responseObject error:&parsingError];
    
    handler(typedObject, parsingError);
    
  }];
  
}

- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams secure:(BOOL)secure completionHandler:(void (^)(SCObjectList *, NSError *))handler {
  
  NSDictionary *params = [self createDic:queryParams];
  
  if (!params) {
    handler(nil, [SCErrorManager errorWithDescription:@"Error: could not strip null-values from dictionary"]);
    return;
  }
  
  [self getRequestToEndpoint:[self resolveEndpoint:type] WithParams:params secure:secure completionHandler:^(id responseObject, NSError *error) {
    
    if (error) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    SCObjectList *objectList = [MTLJSONAdapter modelOfClass:[SCObjectList class] fromJSONDictionary:responseObject error:&parsingError];
    
    //parse Objects in list
    if (!parsingError) {
      objectList.data = [MTLJSONAdapter modelsOfClass:type fromJSONArray:objectList.data error:&parsingError];
    }
    
    handler(objectList, parsingError);
    
  }];
  
}

- (void) createObject:(SCSecuObject *)object secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler {
  
  NSDictionary *params = [self createDic:object];
  
  if (!params) {
    handler(nil, [SCErrorManager errorWithDescription:@"Error: could not strip null-values from dictionary"]);
    return;
  }
  
  [self postRequestToEndpoint:[self resolveEndpoint:[object class]] WithParams:params secure:secure completionHandler:^(id responseObject, NSError *error) {
    
    if (error) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    id typedObject = [MTLJSONAdapter modelOfClass:[object class] fromJSONDictionary:responseObject error:&parsingError];
    
    handler(typedObject, parsingError);
    
  }];
  
}

- (void) updateObject:(SCSecuObject *)object secure:(BOOL)secure completionHandler:(void (^)(SCSecuObject *, NSError *))handler {
  
  NSDictionary *params = [self createDic:object];
  
  if (!params) {
    handler(nil, [SCErrorManager errorWithDescription:@"Error: could not strip null-values from dictionary"]);
    return;
  }
  
  [self putRequestToEndpoint:[self resolveEndpoint:[object class]] WithParams:params secure:secure completionHandler:^(id responseObject, NSError *error) {
    
    if (error) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    SCSecuObject *typedObject = [MTLJSONAdapter modelOfClass:[object class] fromJSONDictionary:responseObject error:&parsingError];
    
    handler(typedObject, parsingError);
    
  }];
  
}

- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id responseObject, NSError *error))handler {
  
  NSDictionary *params = [self createDic:arg];
  if (!params) {
    handler(nil, [SCErrorManager errorWithDescription:@"Error: could not strip null-values from dictionary"]);
    return;
  }
  
  [self putRequestToEndpoint:[self resolveEndpoint:type args:@[objectId, action, actionArg]] WithParams:params secure:secure completionHandler:^(id responseObject, NSError *error) {
    
    if (error) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    id typedObject = [MTLJSONAdapter modelOfClass:type fromJSONDictionary:responseObject error:&parsingError];
    
    handler(typedObject, parsingError);
    
  }];
  
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(bool, NSError *))handler {
  
  [self deleteRequestToEndpoint:[self resolveEndpoint:type args:@[objectId]] WithParams:nil secure:secure completionHandler:^(id responseObject, NSError *error) {
    
    if (!error) {
      handler(true, nil);
    } else {
      handler(false, error);
    }
    
  }];
  
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg secure:(BOOL)secure completionHandler:(void (^)(bool, NSError *))handler {
  
  [self deleteRequestToEndpoint:[self resolveEndpoint:type args:@[objectId, action, actionArg]] WithParams:nil secure:secure completionHandler:^(id responseObject, NSError *error) {
    
    if (!error) {
      handler(true, nil);
    } else {
      handler(false, error);
    }
    
  }];
  
}

- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id responseObject, NSError *error))handler {
  
  NSDictionary *params = [self createDic:arg];
  if (!params) {
    handler(nil, [SCErrorManager errorWithDescription:@"Error: could not strip null-values from dictionary"]);
    return;
  }
  
  [self postRequestToEndpoint:[self resolveEndpoint:type args:@[objectId, action, actionArg]] WithParams:params secure:secure completionHandler:handler];
  
}

- (void) execute:(NSString*)appId command:(NSString*)command arg:(NSDictionary*)arg secure:(BOOL)secure completionHandler:(void (^)(id responseObject, NSError *error))handler {
  
  [self postRequestToEndpoint:[self resolveEndpoint:nil args:@[appId, command]] WithParams:arg secure:secure completionHandler:handler];
  
}

- (void)execute:(NSString *)appId command:(NSString *)command arg:(NSDictionary *)arg completionHandler:(void (^)(id responseObject, NSError *error))handler {
  
  [self postRequestToEndpoint:[self resolveEndpoint:nil args:@[appId, command]] WithParams:arg secure:false completionHandler:handler];
  
}

- (void) post:(NSString*)endpoint withAuth:(BOOL)secure withParams:(id)params completionHandler:(void (^)(id responseObject, NSError *error))handler {
  
  AFHTTPRequestOperationManager *man = (secure) ? self.operationManager : self.authOperationManager;
  
  NSString *host = (secure) ? self.configuration.baseUrl : self.configuration.authUrl;
  
  [man POST:[NSString stringWithFormat:@"%@%@", host, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    handler(responseObject, nil);
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    handler(nil, error);
    
  }];
  
}

- (void) close {
  
}


@end
