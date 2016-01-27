//
//  SCIdentService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCSmartIdent.h"

@interface SCSmartIdentService : SCAbstractService

- (void) getIdentsList:(void (^)(SCObjectList *, SecuError *))handler;

- (void) getIdents:(void (^)(NSArray *, SecuError *))handler;

- (void) readIdent:(NSString*)id completionHandler:(void (^)(SCSmartIdent *, SecuError *))handler;

@end
