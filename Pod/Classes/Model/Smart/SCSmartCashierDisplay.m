//
//  SCSmartCashierDisplay.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartCashierDisplay.h"

@implementation SCSmartCashierDisplay

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"deviceId":@"device_id"
                                                                  }];
}


@end
