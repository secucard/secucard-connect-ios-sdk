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

- (void) open:(void (^)(bool, NSError *))handler {
  handler(false, [SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) close {
  [SCErrorManager handleError:[SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]];
}

- (void) getObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(id, NSError *))handler {
  [self getObject:type objectId:objectId secure:kSecureStandard completionHandler:handler];
}

- (void) getObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler{
  handler(nil, [SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *, NSError *))handler {
  [self findObjects:type queryParams:queryParams secure:kSecureStandard completionHandler:handler];
}

- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams secure:(BOOL)secure completionHandler:(void (^)(SCObjectList *, NSError *))handler {
  handler(nil, [SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) createObject:(SCSecuObject*)object completionHandler:(void (^)(id, NSError *))handler {
  [self createObject:object secure:kSecureStandard completionHandler:handler];
}

- (void) createObject:(SCSecuObject*)object secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler {
  handler(nil, [SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) updateObject:(SCSecuObject*)object completionHandler:(void (^)(SCSecuObject *, NSError *))handler {
  [self updateObject:object secure:kSecureStandard completionHandler:handler];
}

- (void) updateObject:(SCSecuObject*)object secure:(BOOL)secure completionHandler:(void (^)(SCSecuObject *, NSError *))handler {
  handler(nil, [SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, NSError *))handler {
  [self updateObject:type objectId:objectId action:action actionArg:actionArg arg:arg secure:kSecureStandard completionHandler:handler];
}

- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler {
  handler(nil, [SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(bool, NSError *))handler {
  [self deleteObject:type objectId:objectId secure:kSecureStandard completionHandler:handler];
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(bool, NSError *))handler {
  handler(nil, [SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg completionHandler:(void (^)(bool, NSError *))handler {
  [self deleteObject:type objectId:objectId action:action actionArg:actionArg secure:kSecureStandard completionHandler:handler];
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg secure:(BOOL)secure completionHandler:(void (^)(bool, NSError *))handler {
  handler(nil, [SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, NSError *))handler {
  [self execute:type objectId:objectId action:action actionArg:actionArg arg:arg secure:kSecureStandard completionHandler:handler];
}

- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler {
  handler(nil, [SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) execute:(NSString*)appId action:(NSString*)action actionArg:(NSDictionary*)actionArg completionHandler:(void (^)(id, NSError *))handler {
  [self execute:appId action:action actionArg:actionArg secure:kSecureStandard completionHandler:handler];
}

- (void) execute:(NSString*)appId action:(NSString*)action actionArg:(id)actionArg secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler {
  handler(nil, [SCErrorManager errorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

@end
