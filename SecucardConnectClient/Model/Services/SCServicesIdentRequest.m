//
//  SCServicesIdentRequest.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCServicesIdentRequest.h"

@implementation SCServicesIdentRequest

+ (NSString *)object {
  return @"Services.Identrequests";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"ownerTransactionId":@"owner_transaction_id",
                                                                  @"persons":@"person"
                                                                  }];
}


@end
