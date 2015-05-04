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
- (PMKPromise*) getObject:(Class)type objectId:(NSString*)objectId;
- (PMKPromise*) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams;
- (PMKPromise*) createObject:(SCSecuObject*)object;
- (PMKPromise*) updateObject:(SCSecuObject*)object;
- (PMKPromise*) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg;
- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId;
- (PMKPromise*) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg;
- (PMKPromise*) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg;
- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action actionArg:(NSDictionary*)actionArg;
- (PMKPromise*) close;

@end

@interface SCServiceManager : NSObject <SCServiceManagerProtocol>

@end
