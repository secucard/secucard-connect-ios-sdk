//
//  SCServiceManager.m
//  Pods
//
//  Created by Jörn Schmidt on 29.04.15.
//
//

#import "SCServiceManager.h"
#import "SCErrorManager.h"
#import "SCSecuObject.h"

#define kSecureStandard TRUE

@implementation SCServiceManager

- (PMKPromise*) open {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (void) close {
  
  [SCErrorManager handleError:[SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]];
  
}

- (PMKPromise*) getObject:(Class)type objectId:(NSString*)objectId {
  return [self getObject:type objectId:objectId secure:kSecureStandard];
}

- (PMKPromise*) getObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams {
  return [self findObjects:type queryParams:queryParams secure:kSecureStandard];
}

- (PMKPromise*) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams secure:(BOOL)secure {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) createObject:(SCSecuObject*)object {
  return [self createObject:object secure:kSecureStandard];
}

- (PMKPromise*) createObject:(SCSecuObject*)object secure:(BOOL)secure {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) updateObject:(SCSecuObject*)object {
  return [self updateObject:object secure:kSecureStandard];
}

- (PMKPromise*) updateObject:(SCSecuObject*)object secure:(BOOL)secure {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg {
  return [self updateObject:type objectId:objectId action:action actionArg:actionArg arg:arg secure:kSecureStandard];
}

- (PMKPromise*) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId {
  return [self deleteObject:type objectId:objectId secure:kSecureStandard];
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg {
  return [self deleteObject:type objectId:objectId action:action actionArg:actionArg secure:kSecureStandard];
}

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg secure:(BOOL)secure {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg {
  return [self execute:type objectId:objectId action:action actionArg:actionArg arg:arg secure:kSecureStandard];
}

- (PMKPromise*) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action actionArg:(id)actionArg {
  return [self execute:appId action:action actionArg:actionArg secure:kSecureStandard];
}

- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action actionArg:(id)actionArg secure:(BOOL)secure {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
  }];
  
}

@end
