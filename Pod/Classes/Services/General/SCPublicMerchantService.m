//
//  PublicMerchantService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCPublicMerchantService.h"
#import "SCErrorManager.h"

@implementation SCPublicMerchantService

/**
 *  get instance of service
 *
 *  @return the singleton instance
 */
+ (SCPublicMerchantService*)sharedService
{
  static SCPublicMerchantService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCPublicMerchantService new];
  });
  
  return instance;
}

- (PMKPromise*) getPublicMerchant:(NSString*)id {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithDescription:@"Not Implemented"]);
  }];
  
}

- (PMKPromise*) getPublicMerchants:(SCQueryParams*)params {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithDescription:@"Not Implemented"]);
  }];
  
}

@end
