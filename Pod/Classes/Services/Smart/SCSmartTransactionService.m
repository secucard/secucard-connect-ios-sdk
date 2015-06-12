//
//  SCTransactionService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCSmartTransactionService.h"
#import "SCSmartTransaction.h"

@implementation SCSmartTransactionService

+ (SCSmartTransactionService*)sharedService
{
  static SCSmartTransactionService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCSmartTransactionService new];
  });
  
  return instance;
}

- (void) createTransaction:(SCSmartTransaction*)transaction completionHandler:(void (^)(SCSmartTransaction *, NSError *))handler {
  [self create:transaction onChannel:DefaultChannel completionHandler:handler];
}

- (void) updateTransaction:(SCSmartTransaction*)transaction completionHandler:(void (^)(SCSmartTransaction *, NSError *))handler {
  [self update:transaction onChannel:PersistentChannel completionHandler:^(SCSecuObject *responseObject, NSError *error) {
    handler((SCSmartTransaction*)responseObject, error);
  }];
}

- (void) startTransaction:(NSString*)transactionId type:(NSString*)type completionHandler:(void (^)(SCSmartTransaction *, NSError *))handler {
  [self execute:[SCSmartTransaction class] withId:transactionId action:@"start" actionArg:type arg:nil returnType:[SCSmartTransaction class] onChannel:PersistentChannel completionHandler:handler];
}

@end
