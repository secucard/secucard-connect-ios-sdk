//
//  SCUploadService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCUploadService.h"

@implementation SCUploadService

/**
 *  get instance of service
 *
 *  @return the singleton instance
 */
+ (SCUploadService*)sharedService
{
  static SCUploadService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    
    instance = [SCUploadService new];
    
  });
  
  return instance;
}

- (void)uploadDocument:(SCDocumentUploadsDocument *)base64EncodeDocument completionHandler:(void (^)(SCDocumentUploadsDocument *, NSError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: uploadDocument"];
  
  [[self serviceManagerByChannel:OnDemandChannel] execute:base64EncodeDocument.class objectId:nil action:nil actionArg:nil arg:base64EncodeDocument completionHandler:handler];
  
}

@end
