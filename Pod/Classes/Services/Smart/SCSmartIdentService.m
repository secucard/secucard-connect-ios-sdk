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

- (void) getIdentsList:(void (^)(SCObjectList *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getIdentsList"];
  
  [self getObjectList:[SCSmartIdent class] withParams:nil onChannel:PersistentChannel completionHandler:handler];
}

- (void) getIdents:(void (^)(NSArray *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getIdents"];
  
  [self getList:[SCSmartIdent class] withParams:nil onChannel:PersistentChannel completionHandler:handler];
}

- (void) readIdent:(NSString*)id completionHandler:(void (^)(SCSmartIdent *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: readIdent"];
  
  [self execute:[SCSmartIdent class] withId:id action:@"read" actionArg:nil arg:nil returnType:[SCSmartIdent class] onChannel:PersistentChannel completionHandler:handler];
}

@end
