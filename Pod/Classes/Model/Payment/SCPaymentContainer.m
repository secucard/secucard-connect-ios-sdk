//
//  SCPaymentContainer.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCPaymentContainer.h"

@implementation SCPaymentContainer

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"payment.containers";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"privateData":@"private",
           @"publicData":@"public",
           @"assigned":@"assign"
           }];
}


@end
