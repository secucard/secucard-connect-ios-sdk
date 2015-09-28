//
//  SCSmartProduct.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartProduct.h"
#import "SCSmartProductGroup.h"

@implementation SCSmartProduct

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"id":@"articleNumber",
                                                                  @"productId":@"id",
                                                                  @"groups":@"group"
                                                                  }];
}

+ (NSValueTransformer *)groupsJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[SCSmartProductGroup class]];
}



@end
