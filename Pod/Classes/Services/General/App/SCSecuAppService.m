//
//  SCSecuAppService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCSecuAppService.h"

@implementation SCStoreList

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

- (void)getMerchant:(NSString *)appId argObject:(id)argObject completionHandler:(void (^)(SCGeneralMerchant *, NSError *))handler {
  // TODO: return type makes sense?
  [self execute:appId action:@"getMerchantDetails" arg:argObject returnType:[SCStoreList class] onChannel:OnDemandChannel completionHandler:handler];
}

- (void)getMerchants:(NSString *)appId arg:(SCQueryParams *)arg completionHandler:(void (^)(SCObjectList *, NSError *))handler {
  [self execute:appId action:@"getMyMerchants" arg:arg returnType:[SCStoreList class] onChannel:OnDemandChannel completionHandler:handler];
}

- (void)addCard:(NSString *)appId argObject:(id)argObject completionHandler:(void (^)(bool, NSError *))handler {
  [self execute:appId action:@"addCard" arg:argObject returnType:[NSDictionary class] onChannel:OnDemandChannel completionHandler:^(id responseObject, NSError *error) {
    
    handler((error == nil), error);
    
  }];
}

@end
