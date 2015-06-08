//
//  SCIdentService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCIdentService.h"
#import "SCErrorManager.h"

@implementation SCIdentService

+ (SCIdentService*)sharedService {
  
  static SCIdentService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCIdentService new];
  });
  
  return instance;
  
}

- (void)getIdentRequests:(SCQueryParams *)queryParams completionHandler:(void (^)(NSArray *, NSError *))handler {
  handler(nil, [SCErrorManager errorWithDescription:@"Not implemented"]);
}

- (void)getIdentRequest:(NSString *)id completionHandler:(void (^)(SCServicesIdentRequest *, NSError *))handler {
  handler(nil, [SCErrorManager errorWithDescription:@"Not implemented"]);
}

- (void)getIdentResultsByRequestIds:(NSArray *)identRequestIds downloadAttachments:(BOOL)downloadAttachments completionHandler:(void (^)(NSArray *, NSError *))handler {
  handler(nil, [SCErrorManager errorWithDescription:@"Not implemented"]);
}

- (void)getIdentResultsByRequestsRaw:(NSArray *)requestIds downloadAttachments:(BOOL)downloadAttachments completionHandler:(void (^)(NSArray *, NSError *))handler {
  handler(nil, [SCErrorManager errorWithDescription:@"Not implemented"]);
}

- (void)createIdentRequest:(SCServicesIdentRequest *)newIdentRequest completionHandler:(void (^)(SCServicesIdentRequest *, NSError *))handler {
  handler(nil, [SCErrorManager errorWithDescription:@"Not implemented"]);
}

- (void)getIdentResults:(SCQueryParams *)queryParams downloadAttachments:(BOOL)downloadAttachments completionHandler:(void (^)(NSArray *, NSError *))handler {
  handler(nil, [SCErrorManager errorWithDescription:@"Not implemented"]);
}

- (void)getIdentResult:(NSString *)id downloadAttachments:(BOOL)downloadAttachments completionHandler:(void (^)(SCServicesIdentRequest *, NSError *))handler  {
  handler(nil, [SCErrorManager errorWithDescription:@"Not implemented"]);
}

@end
