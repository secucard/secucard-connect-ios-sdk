//
//  SCErrorPayload.m
//  Pods
//
//  Created by Jörn Schmidt on 05.10.15.
//
//

#import "SCErrorPayload.h"

@implementation SCErrorPayload

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"status":@"status",
                                                                  @"error":@"error",
                                                                  @"errorDetails":@"error_details",
                                                                  @"errorUser":@"error_user",
                                                                  @"code":@"code",
                                                                  @"supportId":@"supportId"
                                                                  }];
}

@end
