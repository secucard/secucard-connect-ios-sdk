//
//  SCUploadService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCUploadService.h"

@implementation SCUploadService

- (void)uploadDocument:(SCDocumentUploadsDocument *)base64EncodeDocument completionHandler:(void (^)(SCDocumentUploadsDocument *, NSError *))handler {
  
  [[self serviceManagerByChannel:OnDemandChannel] execute:base64EncodeDocument.class objectId:nil action:nil actionArg:nil arg:base64EncodeDocument completionHandler:handler];
  
}

@end
