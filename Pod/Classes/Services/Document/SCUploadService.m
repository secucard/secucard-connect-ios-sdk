//
//  SCUploadService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCUploadService.h"

@implementation SCUploadService

-(void)uploadDocument:(SCDocumentUploadsDocument *)base64EncodeDocument onComplete:(void (^)(SCDocumentUploadsDocument *, NSError *))completion {
  
  [SCErrorManager handleErrorWithDescription:@"not implemented"];
  
}

@end
