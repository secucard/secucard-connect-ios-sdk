//
//  SCSecupayPrepaidService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCSecupayPrepayService.h"

@implementation SCSecupayPrepayService

+ (SCSecupayPrepayService*)sharedService {
  
  static SCSecupayPrepayService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCSecupayPrepayService new];
  });
  
  return instance;
  
}

- (void)createPrepay:(SCPaymentSecupayPrepay *)data completionHandler:(void (^)(SCPaymentSecupayPrepay *, NSError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: createPrepay"];
  
  [self create:data onChannel:DefaultChannel completionHandler:handler];
}

- (void)cancelTransaction:(NSString *)transactionId completionHandler:(void (^)(bool, NSError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: cancelTransaction"];
  
  [self execute:[SCPaymentSecupayPrepay class] withId:transactionId action:@"cancel" actionArg:nil arg:nil returnType:nil onChannel:DefaultChannel completionHandler:^(id responseObject, NSError *error) {
    handler((error == nil), error);
  }];
  
}

@end
