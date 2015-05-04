//
//  SCSecuAppService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCSecuAppService.h"

@implementation SCStoreList

@end

@implementation SCSecuAppService

+ (SCSecuAppService*)sharedService
{
  static SCSecuAppService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCSecuAppService new];
  });
  
  return instance;
}

- (PMKPromise*) getMerchant:(NSString*)appId argObject:(id)argObject {
  // TODO: return type makes sense?
  return [self execute:appId action:@"getMerchantDetails" arg:argObject returnType:[SCStoreList class] onChannel:RestChannel];
}

- (PMKPromise*) getMerchants:(NSString*)appId arg:(SCQueryParams*)arg {
  return [self execute:appId action:@"getMyMerchants" arg:arg returnType:[SCStoreList class] onChannel:RestChannel];
}

- (PMKPromise*) addCard:(NSString*)appId argObject:(id)argObject {
  return [self execute:appId action:@"addCard" arg:argObject returnType:[NSDictionary class] onChannel:RestChannel];
}

@end
