//
//  SCServiceManager.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 06.11.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCServiceManager.h"

#define kExchangePrefix   @"/exchange/connect.api"
#define kAPIPrefix        @"/api"
#define kAPIVersion       @"/v2"

// STOMP >> /api:{method}:{rooting-key = General.Accounts.BeaconEnvironment}
// payload {data:blabla, "pid":"me"} // pid wenn Accounts

// REST >> METHOD /api/v2/{rooting-key = General/Accounts/[Me]/BeaconEnvironment} // Me wenn accounts
// payload {data:blabla}

@implementation SCServiceManager

+ (SCServiceManager *)sharedManager
{
  static SCServiceManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCServiceManager new];
  });
  
  return instance;
}

- (void) setupManager
{

}

/**
 *  Make a service call with a service call wrapper object
 *
 *  @param serviceCall     wrapper object
 *  @param completionBlock completion block
 *  @param errorBlock      error block
 */
- (PMKPromise*) makeCall:(SCServiceCallWrapper*)serviceCall withType:(ServiceType)type
{
  return [self makeCall:serviceCall.action withMethod:serviceCall.method params:serviceCall.data pid:serviceCall.pid sid:serviceCall.sid using:type];
}

- (PMKPromise*) makeCall:(NSString*)call withMethod:(CallMethod)method params:(id)params pid:(NSString*)pid sid:(NSString*)sid using:(ServiceType)serviceType
{
  
  NSString *typedCall = [self serviceCall:call withServiceType:serviceType andServiceMethod:method andPid:pid andSid:sid];
  
  if (serviceType == ServiceTypeStomp) {
    
    NSMutableDictionary *sendParams = [params mutableCopy];
    
    if (pid != nil) {
      [sendParams setObject:pid forKey:@"pid"];
    }
    
    if (sid != nil) {
      [sendParams setObject:sid forKey:@"sid"];
    }
    
    return [[SCStompManager sharedManager] sendMessage:sendParams toExchange:typedCall];
    
  }
  else if (serviceType == ServiceTypeRest)
  {
    switch (method) {
        
      case MethodGet:
        return [[SCRestServiceManager sharedManager] getRequestToEndpoint:typedCall WithParams:params];
        
      case MethodAdd:
        return [[SCRestServiceManager sharedManager] postRequestToEndpoint:typedCall WithParams:params];
        
      case MethodUpdate:
        return [[SCRestServiceManager sharedManager] putRequestToEndpoint:typedCall WithParams:params];
      
      case MethodRemove:
        return [[SCRestServiceManager sharedManager] deleteRequestToEndpoint:typedCall WithParams:params];
        
      case MethodExecute:
        return [[SCRestServiceManager sharedManager] postRequestToEndpoint:typedCall WithParams:params];
        
      default:
        return nil;
    }
  }
  
}

- (NSString*) serviceCall:(NSString*)call withServiceType:(ServiceType)serviceType andServiceMethod:(CallMethod)method andPid:(NSString*)pid andSid:(NSString*)sid
{
  
  switch (serviceType) {
    case ServiceTypeRest:
    {
      // make basic conversion
      NSString *callString = [call stringByReplacingOccurrencesOfString:@"." withString:@"/"];
      
      // add ME to Accounts-Path
      if (pid != nil)
      {
        callString = [callString stringByReplacingOccurrencesOfString:@"{pid}/" withString:[NSString stringWithFormat:@"%@/", pid]];
      }
      else
      {
        callString = [callString stringByReplacingOccurrencesOfString:@"{pid}/" withString:@""];
      }
      
      // add SID if there
      if (sid != nil)
      {
        callString = [callString stringByAppendingString:[NSString stringWithFormat:@"/%@", sid]];
      }
      
      // if not an auth call add api and version to it
//      if (![callString containsString:@"oauth"])
//      {
        // combine all
        //c = [NSString stringWithFormat:@"%@%@%@", kAPIPrefix, kAPIVersion, c];
//      }
      
      return callString;
      
    }
    case ServiceTypeStomp:
    {
      NSString *methodString;
      
      switch (method) {
        case MethodGet:
          methodString = @"get";
          break;
        case MethodAdd:
          methodString = @"add";
          break;
        case MethodUpdate:
          methodString = @"update";
          break;
        case MethodRemove:
          methodString = @"remove";
          break;
        case MethodExecute:
          methodString = @"execute";
          break;

        default:
          break;
      }
      
      NSString *c = [call stringByReplacingOccurrencesOfString:@"{pid}." withString:@""];
      
      // make basic conversion
      return [NSString stringWithFormat:@"%@%@:%@:%@", kExchangePrefix, kAPIPrefix, methodString, c];
      
    }
      
    default:
      return nil;
      break;
  }
}

@end
