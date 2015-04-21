//
//  SCServicesIdResultIdentificationDocument.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCServicesIdResultIdentificationDocument.h"

@implementation SCServicesIdResultIdentificationDocument

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"dateIssued":@"dateissued",
           @"validUntil":@"validuntil"
           }];
}


@end
