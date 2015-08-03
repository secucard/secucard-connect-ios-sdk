//
//  SCSecuAppService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCSecuAppService.h"
#import "SCGeneralStore.h"

@implementation SCStoreList

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)dataJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[SCGeneralStore class]];
}

@end

@implementation SCSecuAppService

+ (SCSecuAppService*)sharedService
{
  static SCSecuAppService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCSecuAppService new];
  });
  
  return instance;
}

- (void)getMerchant:(NSString *)appId argObject:(id)argObject completionHandler:(void (^)(SCStoreList *list, NSError *error))handler {

  [self execute:appId action:@"getMerchantDetails" arg:argObject returnType:[SCStoreList class] onChannel:OnDemandChannel completionHandler:^(id list, NSError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    SCStoreList *storeList = [MTLJSONAdapter modelOfClass:SCStoreList.class fromJSONDictionary:list error:&parsingError];
    
    if (parsingError != nil) {
      handler(nil, parsingError);
      return;
    }
    
    handler(storeList, nil);
    
  }];
  
}

- (void)getMerchants:(NSString *)appId arg:(SCQueryParams *)arg completionHandler:(void (^)(SCStoreList *list, NSError *error))handler {
  
  [self execute:appId action:@"getMyMerchants" arg:arg returnType:[SCStoreList class] onChannel:OnDemandChannel completionHandler:^(id list, NSError *error) {
    
    if (error != nil) {
      handler(nil, error);
      return;
    }
    
    NSError *parsingError = nil;
    SCStoreList *storeList = [MTLJSONAdapter modelOfClass:SCStoreList.class fromJSONDictionary:list error:&parsingError];
    
    if (parsingError != nil) {
      handler(nil, parsingError);
      return;
    }
    
    handler(storeList, nil);
    
  }];
}

- (void)addCard:(NSString *)appId argObject:(id)argObject completionHandler:(void (^)(bool, NSError *))handler {
  [self execute:appId action:@"addCard" arg:argObject returnType:[NSDictionary class] onChannel:OnDemandChannel completionHandler:^(id responseObject, NSError *error) {
    
    handler((error == nil), error);
    
  }];
}

@end
