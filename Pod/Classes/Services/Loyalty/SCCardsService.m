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

- (PMKPromise*) getCard:(NSString*)id {
  
  return [[self serviceManagerByChannel:OnDemandChannel] getObject:[SCLoyaltyCard class] objectId:id];
  
}

- (PMKPromise*) getCards:(SCQueryParams*)queryParams {
  
  return [[self serviceManagerByChannel:OnDemandChannel] findObjects:[SCLoyaltyCard class] queryParams:queryParams];
  
}

- (PMKPromise*) assignUserToCard:(NSString*)cardNumber pin:(id)pin {
  
  return [[self serviceManagerByChannel:OnDemandChannel] execute:[SCLoyaltyCard class] objectId:cardNumber action:@"assignUser" actionArg:@"me" arg:pin];
  
}

- (PMKPromise*) deleteUserFromCard:(NSString*)cardNumber {
  
  return [[self serviceManagerByChannel:OnDemandChannel] deleteObject:[SCLoyaltyCard class] objectId:cardNumber action:@"assignUser" actionArg:@"me"];
  
}

@end
