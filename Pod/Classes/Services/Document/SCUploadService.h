//
//  SCUploadService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"

#import "SCDocumentUploadsDocument.h"

@interface SCUploadService : SCAbstractService

- (void) uploadDocument:(SCDocumentUploadsDocument*)base64EncodeDocument onComplete:(void(^)(SCDocumentUploadsDocument *document, NSError *error))completion;

@end
