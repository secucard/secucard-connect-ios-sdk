//
//  SCCardsService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCCardsService.h"

@implementation SCCardsService

+ (SCCardsService*)sharedService {
  static SCCardsService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCCardsService new];
  });
  
  return instance;
}

- (void) getCard:(NSString*)id completionHandler:(void (^)(SCLoyaltyCard *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getCard"];
  
  [[self serviceManagerByChannel:OnDemandChannel] getObject:[SCLoyaltyCard class] objectId:id completionHandler:handler];
  
}

- (void) getCards:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getCards"];
  
  [[self serviceManagerByChannel:OnDemandChannel] findObjects:[SCLoyaltyCard class] queryParams:queryParams completionHandler:handler];
  
}

- (void) assignUserToCard:(NSString*)cardNumber pin:(id)pin completionHandler:(void (^)(bool, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: assignUserToCard"];
  
  [[self serviceManagerByChannel:OnDemandChannel] execute:[SCLoyaltyCard class] objectId:cardNumber action:@"assignUser" actionArg:@"me" arg:pin completionHandler:^(id responseObject, SecuError *error) {
    
    handler((error == nil), error);
    
  }];
  
}

- (void) deleteUserFromCard:(NSString*)cardNumber completionHandler:(void (^)(bool, SecuError *))handler {

  [SCLogManager info:@"CONNECT-SDK: deleteUserFromCard"];
  
  [[self serviceManagerByChannel:OnDemandChannel] deleteObject:[SCLoyaltyCard class] objectId:cardNumber action:@"assignUser" actionArg:@"me" completionHandler:handler];
  
}

@end
