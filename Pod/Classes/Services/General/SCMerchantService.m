//
//  SCMerchantService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCMerchantService.h"

@implementation SCMerchantService

/**
 *  get instance of service
 *
 *  @return the singleton instance
 */
+ (SCMerchantService*)sharedService
{
  static SCMerchantService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCMerchantService new];
  });
  
  return instance;
}


@end
