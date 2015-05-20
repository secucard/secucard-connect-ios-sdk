//
//  SCServiceManager.h
//  Pods
//
//  Created by Jörn Schmidt on 29.04.15.
//
//

#import <Foundation/Foundation.h>
#import <PromiseKit/PromiseKit.h>
#import "SCQueryParams.h"

#import "SCSecuObject.h"
@protocol SCServiceManagerProtocol <NSObject>

- (PMKPromise*) open;
- (void) close;

- (PMKPromise*) getObject:(Class)type objectId:(NSString*)objectId;
- (PMKPromise*) getObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure;

- (PMKPromise*) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams;
- (PMKPromise*) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams secure:(BOOL)secure;

- (PMKPromise*) createObject:(SCSecuObject*)object;
- (PMKPromise*) createObject:(SCSecuObject*)object secure:(BOOL)secure;

- (PMKPromise*) updateObject:(SCSecuObject*)object;
- (PMKPromise*) updateObject:(SCSecuObject*)object secure:(BOOL)secure;

- (PMKPromise*) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg;
- (PMKPromise*) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure;

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId;
- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure;

- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg;
- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg secure:(BOOL)secure;

- (PMKPromise*) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg;
- (PMKPromise*) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure;

- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action actionArg:(NSDictionary*)actionArg;
- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action actionArg:(NSDictionary*)actionArg secure:(BOOL)secure;


@end

@interface SCServiceManager : NSObject <SCServiceManagerProtocol>

@end
