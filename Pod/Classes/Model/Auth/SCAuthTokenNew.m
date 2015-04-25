//
//  SCAuthTokenNew.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCAuthTokenNew.h"

@implementation SCAuthTokenNew

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"accessToken":@"access_token",
           @"expiresIn":@"expires_in",
           @"tokenType":@"token_type",
           @"refreshToken":@"refresh_token"
           };
}

@end
