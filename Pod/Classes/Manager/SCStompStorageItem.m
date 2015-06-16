//
//  SCStompStorageItem.m
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import "SCStompStorageItem.h"

@implementation SCStompStorageItem

- (instancetype) initWithHandler:(ReceiptHandler)handler {
  self = [super init];
  if (self)
    self.handler = handler;
  return self;
}

@end
