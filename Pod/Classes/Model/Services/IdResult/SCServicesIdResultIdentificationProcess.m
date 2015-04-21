//
//  SCServicesIdResultIdentificationProcess.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCServicesIdResultIdentificationProcess.h"

@implementation SCServicesIdResultIdentificationProcess

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
           @"identificationTime":@"identificationtime",
           @"transactionNumber":@"transactionnumber"
           }];
}


@end
