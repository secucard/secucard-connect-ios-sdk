//
//  SCMerchantCardsService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCMerchantCardsService.h"

@implementation SCMerchantCardsService

+ (SCMerchantCardsService*)sharedService {
  
  static SCMerchantCardsService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCMerchantCardsService new];
  });
  
  return instance;
  
}

- (void)getMerchantCards:(SCQueryParams *)queryParams completionHandler:(void (^)(SCObjectList *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getMerchantCards"];
  
  [self getObjectList:[SCLoyaltyMerchantCard class] withParams:queryParams onChannel:PersistentChannel completionHandler:handler];
}

- (void)getMerchantCard:(NSString *)id completionHandler:(void (^)(SCLoyaltyMerchantCard *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getMerchantCard"];
  
  [self get:[SCLoyaltyMerchantCard class] withId:id onChannel:DefaultChannel completionHandler:handler];
}


@end
