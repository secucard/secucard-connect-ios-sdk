//
//  PublicMerchantService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCPublicMerchantService.h"
#import "SCGeneralPublicMerchant.h"
#import "SCLogManager.h"

@implementation SCPublicMerchantService

+ (SCPublicMerchantService*)sharedService
{
  static SCPublicMerchantService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCPublicMerchantService new];
  });
  
  return instance;
}

- (void)getPublicMerchant:(NSString *)id completionHandler:(void (^)(SCGeneralPublicMerchant *, NSError *))handler {
  [self get:[SCGeneralPublicMerchant class] withId:id onChannel:DefaultChannel completionHandler:handler];
}

- (void)getPublicMerchants:(SCQueryParams *)params completionHandler:(void (^)(SCObjectList *, NSError *))handler {
  [self getObjectList:[SCGeneralPublicMerchant class] withParams:params onChannel:DefaultChannel completionHandler:handler];
}

@end
