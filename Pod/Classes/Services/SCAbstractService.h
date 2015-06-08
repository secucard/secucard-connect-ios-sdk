//
//  SCAbstractService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>

#import "SCServiceManager.h"
#import "SCGlobals.h"
#import "SCSecuObject.h"
#import "SCObjectList.h"

@interface SCAbstractService : NSObject

- (SCServiceManager*) serviceManagerByChannel:(ServiceChannel)channel;

- (void) get:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, NSError *))handler;

- (void) getList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel completionHandler:(void (^)(NSArray *, NSError *))handler;

- (void) getObjectList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel completionHandler:(void (^)(SCObjectList *, NSError *))handler;
                           
- (void) postProcessObjects:(NSArray*)list completionHandler:(void (^)(NSArray *, NSError *))handler;
                           
- (void) update:(id)object onChannel:(ServiceChannel)channel completionHandler:(void (^)(SCSecuObject *, NSError *))handler;
                           
- (void) execute:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, NSError *))handler;
                           
- (void) execute:(NSString*)appId action:(NSString*)action arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, NSError *))handler;
                                          
- (void) create:(id)object onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, NSError *))handler;
                                                        
- (void) delete:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel completionHandler:(void (^)(bool, NSError *))handler;
                                                        
- (void) delete:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg onChannel:(ServiceChannel)channel completionHandler:(void (^)(bool, NSError *))handler;
                                                        
@end
