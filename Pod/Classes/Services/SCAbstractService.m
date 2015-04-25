//
//  SCAbstractService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCErrorManager.h"
#import "SCConnectClient.h"

@implementation SCAbstractService

- (void) get:(Class)type withId:(NSString*)idString onChannel:(ServiceChannel)channel onComplete:(void (^)(id object, NSError *error))completion {
  
}

- (void) getList:(Class)type withParams:(SCQueryParams*)params onChannel:(ServiceChannel)channel onComplete:(void (^)(NSArray *list, NSError *error))completion {
  
}

- (void) getObjectList:(Class)type withParams:(SCQueryParams*)params onChannel:(ServiceChannel)channel onComplete:(void (^)(SCObjectList *list, NSError *error))completion {
  
}

- (void) update:(MTLModel*)object onChannel:(ServiceChannel)channel onComplete:(void (^)(SCSecuObject *object, NSError *error))completion {
  
}

- (void) execute:(Class)type withId:(NSString*)idString action:(NSString*)action withArg:(id)actionArg returning:(Class)returnType onChannel:(ServiceChannel)channel onComplete:(void (^)(id object, NSError *error))completion {
  
}

- (void) executeAppId:(NSString*)appId action:(NSString*)action withArg:(id)actionArg returning:(Class)returnType onChannel:(ServiceChannel)channel onComplete:(void (^)(id object, NSError *error))completion {
  
}

- (void) create:(MTLModel*)object onChannel:(ServiceChannel)channel onComplete:(void (^)(id object, NSError *error))completion {
  
}

- (void) delete:(Class)type withId:(NSString*)idString onChannel:(ServiceChannel)channel onComplete:(void (^)(BOOL success, NSError *error))completion {
  
}

- (void) delete:(Class)type withId:(NSString*)idString action:(NSString*)action withArg:(id)actionArg onChannel:(ServiceChannel)channel onComplete:(void (^)(BOOL success, NSError *error))completion {
  
}

@end
