//
//  SCAbstractService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>
#import <PromiseKit/PromiseKit.h>

#import "SCServiceManager.h"
#import "SCGlobals.h"
#import "SCSecuObject.h"
#import "SCObjectList.h"

@interface SCAbstractService : NSObject

- (SCServiceManager*) serviceManagerByChannel:(ServiceChannel)channel;

- (PMKPromise*) get:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel;

- (PMKPromise*) getList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel;

- (PMKPromise*) getObjectList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel;
                           
- (PMKPromise*) postProcessObjects:(NSArray*)list;
                           
- (PMKPromise*) update:(id)object onChannel:(ServiceChannel)channel;
                           
- (PMKPromise*) execute:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel;
                           
- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel;
                                          
- (PMKPromise*) create:(id)object onChannel:(ServiceChannel)channel;
                                                        
- (PMKPromise*) delete:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel;
                                                        
- (PMKPromise*) delete:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg onChannel:(ServiceChannel)channel;
                                                        
@end
