//
//  SCDocumentUploadsDocument.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCDocumentUploadsDocument.h"

@implementation SCDocumentUploadsDocument

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.object = @"document.uploads";
  }
  return self;
}
@end
