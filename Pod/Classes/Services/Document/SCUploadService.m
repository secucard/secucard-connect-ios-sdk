//
//  SCUploadService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCUploadService.h"

@implementation SCUploadService

-(PMKPromise*)uploadDocument:(SCDocumentUploadsDocument *)base64EncodeDocument {
  
  return [[self serviceManagerByChannel:OnDemandChannel] execute:base64EncodeDocument.class objectId:nil action:nil actionArg:nil arg:base64EncodeDocument];
  
}

@end
