//
//  SCServicesIdentRequest.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCServicesIdentRequest.h"

@implementation SCServicesIdentRequest

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"services.identrequests";
  }
  return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
           @"ownerTransactionId":@"owner_transaction_id",
           @"persons":@"person"
           };
}


@end
