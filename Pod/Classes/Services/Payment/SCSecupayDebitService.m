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

- (PMKPromise*) createTransaction:(SCPaymentSecupayDebit*)data {
  return [self create:data onChannel:DefaultChannel];
}

- (PMKPromise*) cancelTransaction:(NSString*)id {
  return [self execute:[SCPaymentSecupayDebit class] withId:id action:@"cancel" actionArg:nil arg:nil returnType:nil onChannel:DefaultChannel];
}


@end
