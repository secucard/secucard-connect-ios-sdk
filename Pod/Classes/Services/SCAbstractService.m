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
      // TODO: return default
      return nil;
  }
  
}

- (PMKPromise*) get:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NOT_IMPLEMENTED]);
  }];
  
}

- (PMKPromise*) getList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NOT_IMPLEMENTED]);
  }];
  
}

- (PMKPromise*) getObjectList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NOT_IMPLEMENTED]);
  }];
  
}

- (PMKPromise*) postProcessObjects:(NSArray*)list {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NOT_IMPLEMENTED]);
  }];
  
}

- (PMKPromise*) update:(id)object onChannel:(ServiceChannel)channel {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NOT_IMPLEMENTED]);
  }];
  
}

- (PMKPromise*) execute:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NOT_IMPLEMENTED]);
  }];
  
}

- (PMKPromise*) create:(id)object onChannel:(ServiceChannel)channel {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NOT_IMPLEMENTED]);
  }];
  
}

- (PMKPromise*) delete:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NOT_IMPLEMENTED]);
  }];
  
}

- (PMKPromise*) delete:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg onChannel:(ServiceChannel)channel {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NOT_IMPLEMENTED]);
  }];
  
}

@end
