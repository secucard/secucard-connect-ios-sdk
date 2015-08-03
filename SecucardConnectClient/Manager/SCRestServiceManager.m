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
      
      [requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
      
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
      
      [requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
      
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
      
      [requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
      
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
      
      [requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
      
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
    [SCLogManager error:[SCLogManager makeErrorWithDescription:@"Endpoint resolver: class is no subclass of SCSecuObject and as such, can have no endpoint"]];
    return @"";
  }
  
  
  NSString *callString = (!type) ? @"" : [type object];                                       // -> General.PublicMerchants
  
  callString = [callString stringByReplacingOccurrencesOfString:@"." withString:@"/"];        // -> General/PublicMerchants
  
  if (!args) {
    args = @[];
  }
  
  for (int i = 0; i < args.count; i++) {
    
    if (![args[i] isKindOfClass:[NSString class]] || [args[i] isEqualToString:@""]) {
      continue;
    }
    
    callString = [callString stringByAppendingString:[@"/" stringByAppendingString:args[i]]]; // -> General/PublicMerchants/pmc_231234124
    
  }
  
  return callString;
  
}

- (NSString*) resolveAppEndpoint:(NSString*)appId args:(NSArray*)args {
  
  NSString *path = @"General/Apps";
  
  if (appId) {
    path = [path stringByAppendingString:[NSString stringWithFormat:@"/%@", appId]];
  }
  
  path = [path stringByAppendingString:@"/callBackend"];
  
  for (int i = 0; i < args.count; i++) {
    
    if (![args[i] isKindOfClass:[NSString class]] || [args[i] isEqualToString:@""]) {
      continue;
    }
    
    path = [path stringByAppendingString:[@"/" stringByAppendingString:args[i]]]; // -> General/PublicMerchants/pmc_231234124
    
  }
  
  return path;
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

- (void) getObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(id responseObject, NSError *error))handler {
  
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

- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams secure:(BOOL)secure completionHandler:(void (^)(SCObjectList *list, NSError *error))handler {
  
  //NSDictionary *params = [self createDic:queryParams];
  
  NSDictionary *params = [self queryParamsToMap:queryParams];
  
  if (!params) {
    handler(nil, [SCLogManager makeErrorWithDescription:@"Error: could not strip null-values from dictionary"]);
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
    if (!parsingError && objectList.data != nil) {
      objectList.data = [MTLJSONAdapter modelsOfClass:type fromJSONArray:objectList.data error:&parsingError];
    }
    
    handler(objectList, parsingError);
    
  }];
  
}

- (void) createObject:(SCSecuObject *)object secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler {
  
  NSDictionary *params = [self createDic:object];
  
  if (!params) {
    handler(nil, [SCLogManager makeErrorWithDescription:@"Error: could not strip null-values from dictionary"]);
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
    handler(nil, [SCLogManager makeErrorWithDescription:@"Error: could not strip null-values from dictionary"]);
    return;
  }
  
  [self putRequestToEndpoint:[self resolveEndpoint:[object class] args:@[object.id]] WithParams:params secure:secure completionHandler:^(id responseObject, NSError *error) {
    
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
    handler(nil, [SCLogManager makeErrorWithDescription:@"Error: could not strip null-values from dictionary"]);
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

- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg secure:(BOOL)secure completionHandler:(void (^)(bool success, NSError *error))handler {
  
  [self deleteRequestToEndpoint:[self resolveEndpoint:type args:@[objectId, action, actionArg]] WithParams:nil secure:secure completionHandler:^(id responseObject, NSError *error) {
    
    if (!error) {
      handler(true, nil);
    } else {
      handler(false, error);
    }
    
  }];
  
}

- (void)execute:(NSString *)appId action:(NSString *)action actionArg:(NSDictionary *)actionArg secure:(BOOL)secure completionHandler:(void (^)(id responseObject, NSError *error))handler {
  
  NSDictionary *params = [self createDic:actionArg];
  if (!params && actionArg != nil) {
    handler(nil, [SCLogManager makeErrorWithDescription:@"Error: could not strip null-values from dictionary"]);
    return;
  }
  
  [self postRequestToEndpoint:[self resolveAppEndpoint:appId args:@[action]] WithParams:params secure:secure completionHandler:handler];
  
}

- (void)execute:(Class)type objectId:(NSString *)objectId action:(NSString *)action actionArg:(NSString *)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id responseObject, NSError *error))handler {
 
    NSDictionary *params = [self createDic:arg];
    if (!params && arg != nil) {
      handler(nil, [SCLogManager makeErrorWithDescription:@"Error: could not strip null-values from dictionary"]);
      return;
    }
  
  NSMutableArray *argArray = [NSMutableArray new];
  if (objectId) {
    [argArray addObject:objectId];
  }
  if (action) {
    [argArray addObject:action];
  }
  if (actionArg) {
    [argArray addObject:actionArg];
  }
  [self postRequestToEndpoint:[self resolveEndpoint:type args:[NSArray arrayWithArray:argArray]] WithParams:params secure:secure completionHandler:handler];
  
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

- (NSDictionary*) queryParamsToMap:(SCQueryParams*)params {
  
  NSMutableDictionary *map = [NSMutableDictionary new];
  
  if (!params) {
    return map;
  }
  
  BOOL scroll = params.scrollId && ![params.scrollId isEqualToString:@""];
  
  if (scroll) {
    [map setObject:params.scrollId forKey:@"scroll_id"];
  }
  
  BOOL scrollExpire = params.scrollExpire && [params.scrollExpire isEqualToString:@""];
  
  if (scrollExpire) {
    [map setObject:params.scrollExpire forKey:@"scroll_expire"];
  }
  
  if (!scroll && params.count != nil && params.count >= 0) {
    [map setObject:params.count forKey:@"count"];
  }
  
  if (!scroll && !scrollExpire && params.offset != nil && params.offset >= 0) {
    [map setObject:params.offset forKey:@"offset"];
  }
  
  if (params.fields) {
    [map setObject:[params.fields componentsJoinedByString:@","] forKey:@"fields"];
  }
  
  for(id key in params.sortOrder)
    [map setObject:[params.sortOrder objectForKey:key] forKey:[NSString stringWithFormat:@"sort[%@]", key]];
  
  if (params.query && ![params.query isEqualToString:@""]) {
    [map setObject:params.query forKey:@"q"];
  }
  
  if (params.preset && ![params.preset isEqualToString:@""]) {
    [map setObject:params.preset forKey:@"preset"];
  }
  
  if (params.geoQuery != nil) {
    
    if (params.geoQuery.field && ![params.geoQuery.field isEqualToString:@""]) {
      [map setObject:params.geoQuery.field forKey:@"geo[field]"];
    }
    
    if (params.geoQuery.lat) {
      [map setObject:[NSString stringWithFormat:@"%f", params.geoQuery.lat] forKey:@"geo[lat]"];
    }
    
    if (params.geoQuery.lon) {
      [map setObject:[NSString stringWithFormat:@"%f", params.geoQuery.lon] forKey:@"geo[lon]"];
    }
    
    if (params.geoQuery.distance && ![params.geoQuery.distance isEqualToString:@""]) {
      [map setObject:params.geoQuery.distance forKey:@"geo[distance]"];
    }
    
  }
  
  return map;

}


@end
