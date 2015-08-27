//
//  SCStoreService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCStoreService.h"

@implementation SCStoreService

+ (SCStoreService*)sharedService
{
  static SCStoreService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCStoreService new];
  });
  
  return instance;
}

- (void)checkIn:(NSString *)storeId sid:(NSString *)sid completionHandler:(void (^)(bool, NSError *))handler {
  
  [[self serviceManagerByChannel:PersistentChannel] execute:[SCGeneralStore class] objectId:storeId action:@"checkin" actionArg:sid arg:nil completionHandler:^(id responseObject, NSError *error) {
    
    handler((error == nil), error);
    
  }];
  
}

- (void)setDefault:(NSString *)storeId withReason:(SCGeneralStoreSetDefault*)reason completionHandler:(void (^)(bool, NSError *))handler {
  
  [[self serviceManagerByChannel:OnDemandChannel] execute:[SCGeneralStore class] objectId:storeId action:@"setDefault" actionArg:nil arg:reason completionHandler:^(id responseObject, NSError *error) {
    
    handler((error == nil), error);
    
  }];
  
}

- (void)setDefault:(NSString *)storeId completionHandler:(void (^)(bool, NSError *))handler {
  
  [[self serviceManagerByChannel:OnDemandChannel] execute:[SCGeneralStore class] objectId:storeId action:@"setDefault" actionArg:nil arg:nil completionHandler:^(id responseObject, NSError *error) {
    
    handler((error == nil), error);
    
  }];
  
}


- (void)getStores:(SCQueryParams *)queryParams completionHandler:(void (^)(SCObjectList *, NSError *))handler {
  
  [[self serviceManagerByChannel:OnDemandChannel] findObjects:[SCGeneralStore class] queryParams:queryParams completionHandler:handler];
  
}

- (void)getStoreList:(SCQueryParams *)queryParams completionHandler:(void (^)(NSArray *, NSError *))handler {
  [self getList:[SCGeneralStore class] withParams:queryParams onChannel:OnDemandChannel completionHandler:handler];
}

- (void)getStore:(NSString *)pid completionHandler:(void (^)(SCGeneralStore *, NSError *))handler {
  [self get:[SCGeneralStore class] withId:pid onChannel:OnDemandChannel completionHandler:handler];
}

- (void)postProcessObjects:(NSArray *)list completionHandler:(void (^)(NSArray *objects, NSError *error))handler {
 
    for (SCGeneralStore *store in list) {
      NSLog(@"store: %@", store.id);
      // TODO: implement this
//      MediaResource picture = ((Store) object).getLogo();
//      if (picture != null) {
//        if (!picture.isCached()) {
//          picture.download();
//        }
//      }
    }
  
  handler(list, nil);
  
}


@end
