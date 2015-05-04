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

- (PMKPromise*) getIdentRequests:(SCQueryParams*)queryParams {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithDescription:@"Not implemented"]);
  }];
  
}

- (PMKPromise*) getIdentRequest:(NSString*)id {

  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithDescription:@"Not implemented"]);
  }];
  
}

- (PMKPromise*) getIdentResultsByRequestIds:(NSArray*)identRequestIds downloadAttachments:(BOOL)downloadAttachments {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithDescription:@"Not implemented"]);
  }];
  
}

- (PMKPromise*) getIdentResultsByRequestsRaw:(NSArray*)requestIds downloadAttachments:(BOOL)downloadAttachments {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithDescription:@"Not implemented"]);
  }];
  
}

- (PMKPromise*) createIdentRequest:(SCServicesIdentRequest*)newIdentRequest {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithDescription:@"Not implemented"]);
  }];
  
}

- (PMKPromise*) getIdentResults:(SCQueryParams*)queryParams downloadAttachments:(BOOL)downloadAttachments {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithDescription:@"Not implemented"]);
  }];
  
}

- (PMKPromise*) getIdentResult:(NSString*)id downloadAttachments:(BOOL)downloadAttachments  {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    reject([SCErrorManager errorWithDescription:@"Not implemented"]);
  }];
  
}

@end
