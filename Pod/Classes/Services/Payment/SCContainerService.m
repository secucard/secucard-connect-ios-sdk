//
//  SCContainerService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCContainerService.h"

@implementation SCContainerService

+ (SCContainerService*)sharedService {
  
  static SCContainerService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCContainerService new];
  });
  
  return instance;
  
}

- (PMKPromise*) getContainers:(SCQueryParams*)queryParams {
  return [self getList:[SCPaymentContainer class] withParams:queryParams onChannel:DefaultChannel];
}

- (PMKPromise*) createContainer:(SCPaymentContainer*)container {
  return [self create:container onChannel:DefaultChannel];
}

- (PMKPromise*) updateContainer:(SCPaymentContainer*)container {
  return [self update:container onChannel:DefaultChannel];
}

- (PMKPromise*) updateContainerAssignment:(NSString*)containerId customerId:(NSString*)customerId {
  return [self execute:[SCPaymentContainer class] withId:containerId action:@"assign" actionArg:customerId arg:[SCPaymentCustomer new] returnType:[SCPaymentContainer class] onChannel:DefaultChannel];
}

- (PMKPromise*) deleteContainerAssignment:(NSString*)containerId {
  return [self delete:[SCPaymentContainer class] withId:containerId action:@"assign" actionArg:nil onChannel:DefaultChannel];
}

- (PMKPromise*) deleteContainer:(NSString*)id {
  return [self delete:[SCPaymentContainer class] withId:id onChannel:DefaultChannel];
}

@end
