//
//  SCServicesIdResultAttachment.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCServicesIdResultAttachment.h"

@implementation SCServicesIdResultAttachment

- (instancetype)initWithUrl:(NSString*)url andType:(NSString*)type {
  self = [super init];
  if (self) {
    self.url = url;
    self.type = type;
  }
  return self;
}

@end
