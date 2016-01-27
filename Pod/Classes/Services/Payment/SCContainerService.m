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

- (void)getContainers:(SCQueryParams *)queryParams completionHandler:(void (^)(NSArray *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getContainers"];
  
  [self getList:[SCPaymentContainer class] withParams:queryParams onChannel:DefaultChannel completionHandler:handler];
}

- (void)createContainer:(SCPaymentContainer *)container completionHandler:(void (^)(SCPaymentContainer *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: createContainer"];
  
  [self create:container onChannel:DefaultChannel completionHandler:handler];
}

- (void)updateContainer:(SCPaymentContainer *)container completionHandler:(void (^)(SCPaymentContainer *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: updateContainer"];
  
  [self update:container onChannel:DefaultChannel completionHandler:^(SCSecuObject *responseObject, SecuError *error) {
    
    if ([responseObject isKindOfClass:[SCSecuObject class]]) {
      handler((SCPaymentContainer*)responseObject, error);
    } else {
      handler(nil, error);
    }
    
  }];
}

- (void)updateContainerAssignment:(NSString *)containerId customerId:(NSString *)customerId completionHandler:(void (^)(SCPaymentContainer *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: updateContainerAssignment"];
  
  [self execute:[SCPaymentContainer class] withId:containerId action:@"assign" actionArg:customerId arg:[SCPaymentCustomer new] returnType:[SCPaymentContainer class] onChannel:DefaultChannel completionHandler:handler];
}

- (void)deleteContainerAssignment:(NSString *)containerId completionHandler:(void (^)(bool, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: deleteContainerAssignment"];
  
  [self delete:[SCPaymentContainer class] withId:containerId action:@"assign" actionArg:nil onChannel:DefaultChannel completionHandler:handler];
}

- (void)deleteContainer:(NSString *)id completionHandler:(void (^)(bool, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: deleteContainer"];
  
  [self delete:[SCPaymentContainer class] withId:id onChannel:DefaultChannel completionHandler:handler];
}

@end
