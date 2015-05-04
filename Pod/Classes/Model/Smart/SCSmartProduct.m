//
//  SCSmartProduct.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartProduct.h"

@implementation SCSmartProduct

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
 NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"groups":@"group"
                                                                  }];
}


@end
