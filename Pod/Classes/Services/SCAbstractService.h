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
#import "SCGeneralEvent.h"
#import "SCLogManager.h"

typedef void (^EventHandler)(SCGeneralEvent *event);

@interface SCAbstractService : NSObject

@property (nonatomic, retain) NSArray *registeredEventClasses;
@property (nonatomic, retain) NSMutableArray *eventHandlers;

- (SCServiceManager*) serviceManagerByChannel:(ServiceChannel)channel;

- (void) addEventHandler:(EventHandler)handler;

- (void) get:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, SecuError *))handler;

- (void) getList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel completionHandler:(void (^)(NSArray *, SecuError *))handler;

- (void) getObjectList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel completionHandler:(void (^)(SCObjectList *, SecuError *))handler;
                           
- (void) postProcessObjects:(NSArray*)list completionHandler:(void (^)(NSArray *, SecuError *))handler;
                           
- (void) update:(id)object onChannel:(ServiceChannel)channel completionHandler:(void (^)(SCSecuObject *, SecuError *))handler;
                           
- (void) execute:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, SecuError *))handler;
                           
- (void) execute:(NSString*)appId action:(NSString*)action arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, SecuError *))handler;
                                          
- (void) create:(id)object onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, SecuError *))handler;
                                                        
- (void) delete:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel completionHandler:(void (^)(bool, SecuError *))handler;
                                                        
- (void) delete:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg onChannel:(ServiceChannel)channel completionHandler:(void (^)(bool, SecuError *))handler;
                                                        
@end
