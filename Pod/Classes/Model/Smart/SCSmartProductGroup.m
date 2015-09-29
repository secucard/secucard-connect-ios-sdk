//
//  SCSmartProductGroup.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartProductGroup.h"

@implementation SCSmartProductGroup

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"groupLevel":@"level"
                                                                  }];
}

@end
