//
//  SCTransactionService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCTransactionService.h"

@implementation SCTransactionService

+ (SCTransactionService*)sharedService
{
  static SCTransactionService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCTransactionService new];
  });
  
  return instance;
}

- (PMKPromise*) getTransactions:(SCQueryParams*)queryParams {
  return [[self serviceManagerByChannel:OnDemandChannel] findObjects:[SCGeneralTransaction class] queryParams:queryParams];
}

- (PMKPromise*) getTransaction:(NSString*)pid {
  return [[self serviceManagerByChannel:OnDemandChannel] getObject:[SCGeneralTransaction class] objectId:pid];
}


@end
