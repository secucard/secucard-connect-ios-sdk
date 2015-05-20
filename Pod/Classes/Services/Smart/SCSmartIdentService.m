//
//  SCIdentService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCSmartIdentService.h"
#import "SCSmartIdent.h"

@implementation SCSmartIdentService

- (PMKPromise*) getIdentsList {
  return [self getObjectList:[SCSmartIdent class] withParams:nil onChannel:StompChannel];
}

- (PMKPromise*) getIdents {
  return [self getList:[SCSmartIdent class] withParams:nil onChannel:StompChannel];
}

- (PMKPromise*) readIdent:(NSString*)id {
  return [self execute:[SCSmartIdent class] withId:id action:@"read" actionArg:nil arg:nil returnType:[SCSmartIdent class] onChannel:StompChannel];
}

@end
