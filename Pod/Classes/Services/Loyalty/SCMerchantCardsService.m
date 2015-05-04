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

- (PMKPromise*) getMerchantCards:(SCQueryParams*)queryParams {
  
  return [self getObjectList:[SCLoyaltyMerchantCard class] withParams:queryParams onChannel:DefaultChannel];
  
}

- (PMKPromise*) getMerchantCard:(NSString*)id {
  return [self get:[SCLoyaltyMerchantCard class] withId:id onChannel:DefaultChannel];
}


@end
