//
//  SCServicesIdentResult.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCServicesIdentResult.h"

@implementation SCServicesIdentResult

+ (NSString *)object {
  return @"Services.Identresults";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"persons":@"person"
                                                                  }];
}


@end
