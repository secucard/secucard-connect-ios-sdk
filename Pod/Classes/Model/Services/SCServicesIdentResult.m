//
//  SCServicesIdentResult.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCServicesIdentResult.h"

@implementation SCServicesIdentResult

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"services.identresults";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"persons":@"person"
           }];
}


@end
