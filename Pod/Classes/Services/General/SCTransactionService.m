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

- (void)getTransactions:(SCQueryParams *)queryParams completionHandler:(void (^)(SCObjectList *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getTransactions"];
  
  [[self serviceManagerByChannel:OnDemandChannel] findObjects:[SCGeneralTransaction class] queryParams:queryParams completionHandler:handler];
}

- (void)getTransaction:(NSString *)pid completionHandler:(void (^)(SCGeneralTransaction *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getTransaction"];
  
  [[self serviceManagerByChannel:OnDemandChannel] getObject:[SCGeneralTransaction class] objectId:pid completionHandler:handler];
}


@end
