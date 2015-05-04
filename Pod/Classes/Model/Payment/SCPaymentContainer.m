//
//  SCPaymentContainer.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentContainer.h"

@implementation SCPaymentContainer

+ (NSString *)object {
  return @"payment.containers";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"privateData":@"private",
                                                                  @"publicData":@"public",
                                                                  @"assigned":@"assign"
                                                                  }];
}


@end
