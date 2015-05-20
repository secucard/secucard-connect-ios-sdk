//
//  SCNewsService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCNewsService.h"
#import "SCGeneralNews.h"

@implementation SCNewsService

/**
 *  get instance of service
 *
 *  @return the singleton instance
 */
+ (SCNewsService*)sharedService
{
  static SCNewsService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCNewsService new];
  });
  
  return instance;
}

- (PMKPromise*) getNews:(SCQueryParams*)queryParams {
  return [[self serviceManagerByChannel:OnDemandChannel] findObjects:[SCGeneralNews class] queryParams:queryParams];
}

- (PMKPromise*) markRead:(NSString*)pid {
  return [[self serviceManagerByChannel:OnDemandChannel] execute:[SCGeneralNews class] objectId:pid action:@"markRead" actionArg:nil arg:nil];
}

@end
