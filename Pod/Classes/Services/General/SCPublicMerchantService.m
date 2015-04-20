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
