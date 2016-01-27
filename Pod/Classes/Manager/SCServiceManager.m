//
//  SCServiceManager.m
//  Pods
//
//  Created by Jörn Schmidt on 29.04.15.
//
//

#import "SCServiceManager.h"
#import "SCLogManager.h"
#import "SCSecuObject.h"

#import "NSDictionary+NullStripper.h"
#import "NSArray+NullStripper.h"

#import <Mantle/Mantle.h>

#define kSecureStandard TRUE

@implementation SCServiceManager

- (void) open:(void (^)(bool, SecuError *))handler {
  handler(false, [SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) close {
  [SCLogManager error:[SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]];
}

- (void) getObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(id, SecuError *))handler {
  [self getObject:type objectId:objectId secure:kSecureStandard completionHandler:handler];
}

- (void) getObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler{
  handler(nil, [SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *, SecuError *))handler {
  [self findObjects:type queryParams:queryParams secure:kSecureStandard completionHandler:handler];
}

- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams secure:(BOOL)secure completionHandler:(void (^)(SCObjectList *, SecuError *))handler {
  handler(nil, [SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) createObject:(SCSecuObject*)object completionHandler:(void (^)(id, SecuError *))handler {
  [self createObject:object secure:kSecureStandard completionHandler:handler];
}

- (void) createObject:(SCSecuObject*)object secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler {
  handler(nil, [SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) updateObject:(SCSecuObject*)object completionHandler:(void (^)(SCSecuObject *, SecuError *))handler {
  [self updateObject:object secure:kSecureStandard completionHandler:handler];
}

- (void) updateObject:(SCSecuObject*)object secure:(BOOL)secure completionHandler:(void (^)(SCSecuObject *, SecuError *))handler {
  handler(nil, [SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, SecuError *))handler {
  [self updateObject:type objectId:objectId action:action actionArg:actionArg arg:arg secure:kSecureStandard completionHandler:handler];
}

- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler {
  handler(nil, [SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(bool, SecuError *))handler {
  [self deleteObject:type objectId:objectId secure:kSecureStandard completionHandler:handler];
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(bool, SecuError *))handler {
  handler(nil, [SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg completionHandler:(void (^)(bool, SecuError *))handler {
  [self deleteObject:type objectId:objectId action:action actionArg:actionArg secure:kSecureStandard completionHandler:handler];
}

- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg secure:(BOOL)secure completionHandler:(void (^)(bool, SecuError *))handler {
  handler(nil, [SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, SecuError *))handler {
  [self execute:type objectId:objectId action:action actionArg:actionArg arg:arg secure:kSecureStandard completionHandler:handler];
}

- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler {
  handler(nil, [SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}

- (void) execute:(NSString*)appId action:(NSString*)action actionArg:(NSDictionary*)actionArg completionHandler:(void (^)(id, SecuError *))handler {
  [self execute:appId action:action actionArg:actionArg secure:kSecureStandard completionHandler:handler];
}

- (void) execute:(NSString*)appId action:(NSString*)action actionArg:(id)actionArg secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler {
  handler(nil, [SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]);
}


#pragma mark - helper methods

- (NSDictionary*) createDic:(id)object {
  
  NSDictionary *params;
  if (object && [object isKindOfClass:MTLModel.class]) {
    SecuError *paramParsingError = nil;
    params = [MTLJSONAdapter JSONDictionaryFromModel:object error:&paramParsingError];
    
    if (paramParsingError) {
      [SCLogManager error:paramParsingError];
      return nil;
    }
    
    params = [params copy];
    params = [params dictionaryByReplacingNullsWithBlanks];
    
    return params;
    
  } else {
    
    return object;
    
  }
  
}


@end
