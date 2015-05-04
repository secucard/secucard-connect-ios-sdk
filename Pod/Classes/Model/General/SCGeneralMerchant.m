//
//  SCGeneralMerchant.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralMerchant.h"

@implementation SCGeneralMerchant

+ (NSString *)object {
  return @"general.merchants";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"photoMain":@"photo_main"
                                                                  }];
}

@end
