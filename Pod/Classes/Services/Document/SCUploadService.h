//
//  SCUploadService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCErrorManager.h"
#import "SCDocumentUploadsDocument.h"

@interface SCUploadService : SCAbstractService

/**
 *  Uploads a document to the server
 *
 *  @param base64EncodeDocument the document's data
 *
 *  @return a promise which fulfills to SCDocumentUploadsDocument
 */
- (PMKPromise*) uploadDocument:(SCDocumentUploadsDocument*)base64EncodeDocument;

@end
