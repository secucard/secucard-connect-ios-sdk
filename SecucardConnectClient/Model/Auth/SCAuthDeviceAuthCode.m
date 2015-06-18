//
//  SCAuthDeviceAuthCode.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCAuthDeviceAuthCode.h"

@implementation SCAuthDeviceAuthCode

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"deviceCode":@"device_code",
           @"userCode":@"user_code",
           @"verificationUrl":@"verification_url",
           @"expiresIn":@"expires_in"
           }];
}

@end
