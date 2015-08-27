//
//  SCCustomerService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCCustomerService.h"

@implementation SCCustomerService

+ (SCCustomerService*)sharedService {
  
  static SCCustomerService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCCustomerService new];
  });
  
  return instance;
  
}

- (void)getCustomers:(SCQueryParams *)queryParams completionHandler:(void (^)(NSArray *, NSError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getCustomers"];
  
  [self getList:[SCPaymentCustomer class] withParams:queryParams onChannel:DefaultChannel completionHandler:handler];
  
}

- (void)createCustomer:(SCPaymentCustomer *)customer completionHandler:(void (^)(SCPaymentCustomer *, NSError *))handler {

  [SCLogManager info:@"CONNECT-SDK: createCustomer"];
  
  [self create:customer onChannel:DefaultChannel completionHandler:handler];
  
}

- (void)updateCustomer:(SCPaymentCustomer *)customer completionHandler:(void (^)(SCPaymentCustomer *, NSError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: updateCustomer"];
  
  [self update:customer onChannel:DefaultChannel completionHandler:^(SCSecuObject *responseObject, NSError *error) {
    
    if ([responseObject isKindOfClass:[SCSecuObject class]]) {
      handler((SCPaymentCustomer*)responseObject, error);
    } else {
      handler(nil, error);
    }
    
  }];
}

- (void)deleteCustomer:(NSString *)id completionHandler:(void (^)(bool, NSError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: deleteCustomer"];
  
  [self delete:[SCPaymentCustomer class] withId:id onChannel:DefaultChannel completionHandler:handler];
}


@end
