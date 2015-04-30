//
//  SCServiceManager.m
//  Pods
//
//  Created by Jörn Schmidt on 29.04.15.
//
//

#import "SCServiceManager.h"
#import "SCErrorManager.h"

@implementation SCServiceManager

- (PMKPromise*) open {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) getObject:(Class)type objectId:(NSString*)objectId {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) createObject:(id)object {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) updateObject:(id)object {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action actionArg:(NSString*)actionArg {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) close {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}


@end
