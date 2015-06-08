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

- (void) getIdentsList:(void (^)(SCObjectList *, NSError *))handler;

- (void) getIdents:(void (^)(NSArray *, NSError *))handler;

- (void) readIdent:(NSString*)id completionHandler:(void (^)(SCSmartIdent *, NSError *))handler;

@end
