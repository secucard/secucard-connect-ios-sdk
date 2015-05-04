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
  
  NSDictionary *standards = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"dateIssued":@"dateissued",
                                                                  @"validUntil":@"validuntil"
                                                                  }];
}


@end
