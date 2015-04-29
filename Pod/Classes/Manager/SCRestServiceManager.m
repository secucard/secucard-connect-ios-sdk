//
//  SCRestServiceManager.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 02.09.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//
#import "SCRestServiceManager.h"
#import <PromiseKit-AFNetworking/AFNetworking+PromiseKit.h>

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
  [requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
  [requestSerializer setValue:@"Bearer XXX" forHTTPHeaderField:@"Authorization"];
  
  self.authOperationManager = [AFHTTPRequestOperationManager manager];
  [self.authOperationManager setRequestSerializer:[AFJSONRequestSerializer new]];
  [self.authOperationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
  self.operationManager = [AFHTTPRequestOperationManager manager];
  self.operationManager.requestSerializer = requestSerializer;
  [self.operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
 
}

- (PMKPromise*) requestAuthWithParams:(id)params
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    // do the actual request
    [self.authOperationManager POST:[NSString stringWithFormat:@"%@oauth/token", self.configuration.authUrl] parameters:params].then(^(AFHTTPRequestOperation *operation, id responseObject) {
      
      [self.operationManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", responseObject] forHTTPHeaderField:@"Authorization"];
      
      fulfill(responseObject);
      
    }).catch(^(AFHTTPRequestOperation *operation, NSError *error) {
      
      error = [self doBasicErrorHandling:error withOperation:operation];
      reject(error);
      
    });
    
  }];
  
}

/**
 *  sends a generic POST-request, generic means that you can choose endpont information and alike on your own
 *
 *  @param endpoint     endpoint url, like General/Skeletons
 *  @param params       the parameters to send
 */
- (PMKPromise*) postRequestToEndpoint:(NSString*)endpoint WithParams:(id)params
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {

    [[SCAccountManager sharedManager] token].then(^(NSString *token) {
      
      [self.operationManager POST:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        fulfill(responseObject);
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        reject([self doBasicErrorHandling:error withOperation:operation]);
      }];
      
    }).catch(^(NSError *error){
      
      reject(error);
      
    });
    
  }];
  
}


/**
 *  Send a generic GET-request, generic means that you can choose andpoint and alike on your own
 *
 *  @param endpoint     endpoint URL like General/Skeletons
 *  @param params       the parameters to send
 *  @param successBlock successBlock
 *  @param errorBlock   errorBlock
 */
- (PMKPromise*) getRequestToEndpoint:(NSString*)endpoint WithParams:(id)params
{
  
  // TODO: REMOVE
  BOOL needsToken = ![endpoint isEqualToString:@"General/PublicMerchants"];
  // END OF REMOVE
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    if (needsToken) {
      
      [[SCAccountManager sharedManager] token].then(^(NSString *token) {
        
        [self.operationManager GET:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
          fulfill(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          reject([self doBasicErrorHandling:error withOperation:operation]);
        }];
        
      }).catch(^(NSError *error) {
        
        reject(error);
        
      });
      
    } else {
      
      [self.operationManager GET:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        fulfill(responseObject);
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        reject([self doBasicErrorHandling:error withOperation:operation]);
      }];
      
    }
    
    
  }];
  
  
  
  
}

/**
 *  Send a generic GET-request, generic means that you can choose andpoint and alike on your own
 *
 *  @param endpoint     endpoint URL like General/Skeletons
 *  @param params       the parameters to send
 *  @param successBlock successBlock
 *  @param errorBlock   errorBlock
 */
- (PMKPromise*) putRequestToEndpoint:(NSString*)endpoint WithParams:(id)params
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    [[SCAccountManager sharedManager] token].then(^(NSString *token) {
      
      [self.operationManager PUT:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        fulfill(responseObject);
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        reject([self doBasicErrorHandling:error withOperation:operation]);
      }];
      
    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
                                                  
  }];
  
}

/**
 *  Send a generic GET-request, generic means that you can choose andpoint and alike on your own
 *
 *  @param endpoint     endpoint URL like General/Skeletons
 *  @param params       the parameters to send
 *  @param successBlock successBlock
 *  @param errorBlock   errorBlock
 */
- (PMKPromise*) deleteRequestToEndpoint:(NSString*)endpoint WithParams:(NSDictionary*)params
{
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    [[SCAccountManager sharedManager] token].then(^(NSString *token) {
      
      [self.operationManager DELETE:[NSString stringWithFormat:@"%@%@", self.configuration.baseUrl, endpoint] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        fulfill(responseObject);
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        reject([self doBasicErrorHandling:error withOperation:operation]);
      }];
      
    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
    
  }];
  
}

/**
 *  Here we do some basic error handling, not really basic but base
 *
 *  @param error     the NSError
 *  @param operation The opertion the error was raised in
 *
 *  @return the input Error as output
 */
- (NSError*) doBasicErrorHandling:(NSError*)error withOperation:(AFHTTPRequestOperation*)operation
{
  
  //possible action by code
  switch (operation.response.statusCode) {
    case 400: // Invalid
      
      break;
      
    case 401: // Unauthorized
      
      break;
      
    case 403: // Forbidden
      
      break;
      
    case 426: // Update required
      
      break;
      
    case 409: // Conflict
      
      break;
      
    case 500: // Internal
      
      break;
      
    default:
      break;
  }
  
  return error;
}
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

#pragma mark - SCServiceManagerProtocol

- (PMKPromise*) open {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"not implemented"]);
    
  }];
  
}

- (PMKPromise*) getObject:(Class)type objectId:(NSString*)objectId {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"not implemented"]);
    
  }];
  
}

- (PMKPromise*) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"not implemented"]);
    
  }];
  
}

- (PMKPromise*) createObject:(id)object {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"not implemented"]);
    
  }];
  
}

- (PMKPromise*) updateObject:(id)object {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"not implemented"]);
    
  }];
  
}

- (PMKPromise*) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"not implemented"]);
    
  }];
  
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"not implemented"]);
    
  }];
  
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"not implemented"]);
    
  }];
  
}

- (PMKPromise*) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"not implemented"]);
    
  }];
  
}

- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action actionArg:(NSString*)actionArg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"not implemented"]);
    
  }];
  
}

- (PMKPromise*) close {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"not implemented"]);
    
  }];
  
}


@end
