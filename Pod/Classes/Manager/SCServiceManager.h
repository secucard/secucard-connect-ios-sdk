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

@protocol SCServiceManagerProtocol <NSObject>

- (void) open:(void (^)(bool, NSError*)) handler;
- (void) close;

- (void) getObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(id, NSError *))handler;
- (void) getObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler;

- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *list, NSError *))handler;
- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams secure:(BOOL)secure completionHandler:(void (^)(SCObjectList *list, NSError *))handler;

- (void) createObject:(SCSecuObject*)object completionHandler:(void (^)(id, NSError *))handler;
- (void) createObject:(SCSecuObject*)object secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler;

- (void) updateObject:(SCSecuObject*)object completionHandler:(void (^)(SCSecuObject *responseObject, NSError *))handler;
- (void) updateObject:(SCSecuObject*)object secure:(BOOL)secure completionHandler:(void (^)(SCSecuObject *responseObject, NSError *))handler;

- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, NSError *))handler;
- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler;

- (void) deleteObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(bool success, NSError *))handler;
- (void) deleteObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(bool success, NSError *))handler;

- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg completionHandler:(void (^)(bool success, NSError *))handler;
- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg secure:(BOOL)secure completionHandler:(void (^)(bool success, NSError *))handler;

- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, NSError *))handler;
- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler;

- (void) execute:(NSString*)appId action:(NSString*)action actionArg:(NSDictionary*)actionArg completionHandler:(void (^)(id, NSError *))handler;
- (void) execute:(NSString*)appId action:(NSString*)action actionArg:(NSDictionary*)actionArg secure:(BOOL)secure completionHandler:(void (^)(id, NSError *))handler;


@end

@interface SCServiceManager : NSObject <SCServiceManagerProtocol>

@end
