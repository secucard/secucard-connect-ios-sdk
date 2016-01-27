//
//  SCUploadService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCLogManager.h"
#import "SCDocumentUploadsDocument.h"

@interface SCUploadService : SCAbstractService

+ (SCUploadService*)sharedService;

/**
 *  Uploads a document to the server
 *
 *  @param base64EncodeDocument the document's data
 *
 *  @return a promise which resolves to SCDocumentUploadsDocument
 */
- (void) uploadDocument:(SCDocumentUploadsDocument*)base64EncodeDocument completionHandler:(void (^)(SCDocumentUploadsDocument *, SecuError *))handler;

@end
