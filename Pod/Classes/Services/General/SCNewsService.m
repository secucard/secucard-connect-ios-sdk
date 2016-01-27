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

+ (SCNewsService*)sharedService
{
  static SCNewsService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCNewsService new];
  });
  
  return instance;
}

- (void)getNews:(SCQueryParams *)queryParams completionHandler:(void (^)(SCObjectList *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getNews"];
  
  [[self serviceManagerByChannel:OnDemandChannel] findObjects:[SCGeneralNews class] queryParams:queryParams completionHandler:handler];
}

- (void)markRead:(NSString *)pid completionHandler:(void (^)(bool, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: markRead"];
  
  [[self serviceManagerByChannel:OnDemandChannel] execute:[SCGeneralNews class] objectId:pid action:@"markRead" actionArg:nil arg:nil completionHandler:^(id responseObject, SecuError *error) {
    
    handler((error == nil), error);
    
  }];
}

@end
