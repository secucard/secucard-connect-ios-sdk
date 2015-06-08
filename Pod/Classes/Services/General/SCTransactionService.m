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

- (void)getTransactions:(SCQueryParams *)queryParams completionHandler:(void (^)(SCObjectList *, NSError *))handler {
  [[self serviceManagerByChannel:OnDemandChannel] findObjects:[SCGeneralTransaction class] queryParams:queryParams completionHandler:handler];
}

- (void)getTransaction:(NSString *)pid completionHandler:(void (^)(SCGeneralTransaction *, NSError *))handler {
  [[self serviceManagerByChannel:OnDemandChannel] getObject:[SCGeneralTransaction class] objectId:pid completionHandler:handler];
}


@end
