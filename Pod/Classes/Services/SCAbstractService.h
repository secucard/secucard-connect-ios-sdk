//
//  SCAbstractService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>
#import <PromiseKit/PromiseKit.h>
#import "SCQueryParams.h"

#import "SCObjectList.h"
#import "SCSecuObject.h"

typedef enum ChannelType {
  
  ChannelTypeRest,
  ChannelTypeStomp
  
} ChannelType;

@interface SCAbstractService : NSObject

- (void) get:(Class)type withId:(NSString*)idString onChannel:(ChannelType)channel onComplete:(void (^)(id object, NSError *error))completion;

- (void) getList:(Class)type withParams:(SCQueryParams*)params onChannel:(ChannelType)channel onComplete:(void (^)(NSArray *list, NSError *error))completion;

- (void) getObjectList:(Class)type withParams:(SCQueryParams*)params onChannel:(ChannelType)channel onComplete:(void (^)(SCObjectList *list, NSError *error))completion;
  
- (void) update:(MTLModel*)object onChannel:(ChannelType)channel onComplete:(void (^)(SCSecuObject *object, NSError *error))completion;

- (void) execute:(Class)type withId:(NSString*)idString action:(NSString*)action withArg:(id)actionArg returning:(Class)returnType onChannel:(ChannelType)channel onComplete:(void (^)(id object, NSError *error))completion;

- (void) executeAppId:(NSString*)appId action:(NSString*)action withArg:(id)actionArg returning:(Class)returnType onChannel:(ChannelType)channel onComplete:(void (^)(id object, NSError *error))completion;

- (void) create:(MTLModel*)object onChannel:(ChannelType)channel onComplete:(void (^)(id object, NSError *error))completion;

- (void) delete:(Class)type withId:(NSString*)idString onChannel:(ChannelType)channel onComplete:(void (^)(BOOL success, NSError *error))completion;

- (void) delete:(Class)type withId:(NSString*)idString action:(NSString*)action withArg:(id)actionArg onChannel:(ChannelType)channel onComplete:(void (^)(BOOL success, NSError *error))completion;

@end
