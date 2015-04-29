//
//  SCAbstractService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>
#import <PromiseKit/PromiseKit.h>

#import "SCClientConfiguration.h"

#import "SCQueryParams.h"

#import "SCObjectList.h"
#import "SCSecuObject.h"

//#import "SCUploadService.h"
//#import "SCAccountDevicesService.h"
//#import "SCAccountService.h"
//#import "SCMerchantService.h"
//#import "SCNewsService.h"
//#import "SCPublicMerchantService.h"
//#import "SCStoreService.h"
//#import "SCTransactionService.h"
//#import "SCSecuAppService.h"
//#import "SCCardsService.h"
//#import "SCLoyaltyCustomerService.h"
//#import "SCMerchantCardsService.h"
//#import "SCContainerService.h"
//#import "SCCustomerService.h"
//#import "SCSecupayDebitService.h"
//#import "SCSecupayPrepayService.h"
//#import "SCIdentService.h"
//#import "SCCheckinService.h"
//#import "SCDeviceService.h"
//#import "SCSmartIdentService.h"
//#import "SCSmartTransactionService.h"

@interface SCAbstractService : NSObject

- (void) get:(Class)type withId:(NSString*)idString onChannel:(ServiceChannel)channel onComplete:(void (^)(id object, NSError *error))completion;

- (void) getList:(Class)type withParams:(SCQueryParams*)params onChannel:(ServiceChannel)channel onComplete:(void (^)(NSArray *list, NSError *error))completion;

- (void) getObjectList:(Class)type withParams:(SCQueryParams*)params onChannel:(ServiceChannel)channel onComplete:(void (^)(SCObjectList *list, NSError *error))completion;
  
- (void) update:(MTLModel*)object onChannel:(ServiceChannel)channel onComplete:(void (^)(SCSecuObject *object, NSError *error))completion;

- (void) execute:(Class)type withId:(NSString*)idString action:(NSString*)action withArg:(id)actionArg returning:(Class)returnType onChannel:(ServiceChannel)channel onComplete:(void (^)(id object, NSError *error))completion;

- (void) executeAppId:(NSString*)appId action:(NSString*)action withArg:(id)actionArg returning:(Class)returnType onChannel:(ServiceChannel)channel onComplete:(void (^)(id object, NSError *error))completion;

- (void) create:(MTLModel*)object onChannel:(ServiceChannel)channel onComplete:(void (^)(id object, NSError *error))completion;

- (void) delete:(Class)type withId:(NSString*)idString onChannel:(ServiceChannel)channel onComplete:(void (^)(BOOL success, NSError *error))completion;

- (void) delete:(Class)type withId:(NSString*)idString action:(NSString*)action withArg:(id)actionArg onChannel:(ServiceChannel)channel onComplete:(void (^)(BOOL success, NSError *error))completion;

@end