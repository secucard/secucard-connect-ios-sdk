//
//  SCAbstractService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCErrorManager.h"
#import "SCRestServiceManager.h"
#import "SCStompManager.h"

@implementation SCAbstractService

- (SCServiceManager*) serviceManagerByChannel:(ServiceChannel)channel {
  
  switch (channel) {
    case RestChannel:
      return [SCRestServiceManager sharedManager];
    
    case StompChannel:
      return [SCStompManager sharedManager];
      
    default:
      NSLog(@"No Service Manager found for cannel type: %u", channel);
      break;
  }
  
}

#pragma mark - SCServiceManagerProtocol

- (PMKPromise*) open {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"method 'open' needs implementation in subclass"]);
    
  }];
  
}

- (PMKPromise*) getObject:(Class)type objectId:(NSString*)objectId {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"method 'getObject' needs implementation in subclass"]);
    
  }];
  
}

- (PMKPromise*) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"method 'findObjects' needs implementation in subclass"]);
    
  }];
  
}

- (PMKPromise*) createObject:(id)object {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"method 'createObject' needs implementation in subclass"]);
    
  }];
  
}

- (PMKPromise*) updateObject:(id)object {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"method 'updateObject' needs implementation in subclass"]);
    
  }];
  
}

- (PMKPromise*) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"method 'updateObject' needs implementation in subclass"]);
    
  }];
  
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"method 'deleteObject' needs implementation in subclass"]);
    
  }];
  
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"method 'deleteObject' needs implementation in subclass"]);
    
  }];
  
}

- (PMKPromise*) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"method 'execute' needs implementation in subclass"]);
    
  }];
  
}

- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action actionArg:(NSString*)actionArg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"method 'execute' needs implementation in subclass"]);
    
  }];
  
}

- (PMKPromise*) close {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    reject([SCErrorManager errorWithDescription:@"method 'close' needs implementation in subclass"]);
    
  }];
  
}

@end
