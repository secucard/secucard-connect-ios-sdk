//
//  MTLModel+Secucard.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"
#import <objc/runtime.h>

@implementation MTLModel (Secucard)

- (void)setObject:(NSString *)object {
  objc_setAssociatedObject(self, @selector(object), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString*) object {
  return objc_getAssociatedObject(self, @selector(object));
}

@end
