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
  return @"services.identrequests";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"ownerTransactionId":@"owner_transaction_id",
           @"persons":@"person"
           };
}


@end
