//
//  SCSecupayDebitService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCSecupayDebitService.h"

@implementation SCSecupayDebitService

+ (SCSecupayDebitService*)sharedService {

  static SCSecupayDebitService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCSecupayDebitService new];
  });
  
  return instance;
  
}

- (void)createTransaction:(SCPaymentSecupayDebit *)data completionHandler:(void (^)(SCPaymentSecupayDebit *, NSError *))handler {
  [self create:data onChannel:DefaultChannel completionHandler:handler];
}

- (void)cancelTransaction:(NSString *)transactionId completionHandler:(void (^)(bool, NSError *))handler {

  [self execute:[SCPaymentSecupayDebit class] withId:transactionId action:@"cancel" actionArg:nil arg:nil returnType:nil onChannel:DefaultChannel completionHandler:^(id responseObject, NSError *error) {
    handler((error == nil), error);
  }];
  
}

@end
