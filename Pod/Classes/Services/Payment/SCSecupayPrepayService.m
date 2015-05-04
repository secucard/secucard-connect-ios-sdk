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

- (PMKPromise*) createPrepay:(SCPaymentSecupayPrepay*)data {
  return [self create:data onChannel:DefaultChannel];
}

- (PMKPromise*) cancelTransaction:(NSString*)id {
  return [self execute:[SCPaymentSecupayPrepay class] withId:id action:@"cancel" actionArg:nil arg:nil returnType:nil onChannel:DefaultChannel];
}

@end
