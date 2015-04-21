//
//  SCTransportStatus.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCTransportStatus.h"

@implementation SCTransportStatus


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *mapping = [NSDictionary mtl_identityPropertyMapWithModel:self];
  
  return [mapping mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                @"errorDetails":@"error_details",
                                                                @"errorDescription":@"error_description",
                                                                @"errorUser":@"error_user"
                                                                }];

}


@end
