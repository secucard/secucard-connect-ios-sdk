//
//  SCServiceManager.h
//  Pods
//
//  Created by Jörn Schmidt on 29.04.15.
//
//

#import <Foundation/Foundation.h>
#import "SCQueryParams.h"
#import "SCSecuObject.h"
#import "SCObjectList.h"
#import "SecuError.h"

@protocol SCServiceManagerProtocol <NSObject>

- (void) open:(void (^)(bool, SecuError*)) handler;
- (void) close;

- (void) getObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(id, SecuError *))handler;
- (void) getObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler;

- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *list, SecuError *))handler;
- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams secure:(BOOL)secure completionHandler:(void (^)(SCObjectList *list, SecuError *))handler;

- (void) createObject:(SCSecuObject*)object completionHandler:(void (^)(id, SecuError *))handler;
- (void) createObject:(SCSecuObject*)object secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler;

- (void) updateObject:(SCSecuObject*)object completionHandler:(void (^)(SCSecuObject *responseObject, SecuError *))handler;
- (void) updateObject:(SCSecuObject*)object secure:(BOOL)secure completionHandler:(void (^)(SCSecuObject *responseObject, SecuError *))handler;

- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, SecuError *))handler;
- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler;

- (void) deleteObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(bool success, SecuError *))handler;
- (void) deleteObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(bool success, SecuError *))handler;

- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg completionHandler:(void (^)(bool success, SecuError *))handler;
- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg secure:(BOOL)secure completionHandler:(void (^)(bool success, SecuError *))handler;

- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, SecuError *))handler;
- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler;

- (void) execute:(NSString*)appId action:(NSString*)action actionArg:(NSDictionary*)actionArg completionHandler:(void (^)(id, SecuError *))handler;
- (void) execute:(NSString*)appId action:(NSString*)action actionArg:(NSDictionary*)actionArg secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler;


@end

@interface SCServiceManager : NSObject <SCServiceManagerProtocol>

- (NSDictionary*) createDic:(id)object;

@end
