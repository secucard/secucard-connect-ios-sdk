//
//  SCDocumentUploadsDocument.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

@interface SCDocumentUploadsDocument : SCSecuObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSDate *created;

@end
