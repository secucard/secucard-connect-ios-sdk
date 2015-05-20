//
//  SCIdentService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"

@interface SCSmartIdentService : SCAbstractService

- (PMKPromise*) getIdentsList;

- (PMKPromise*) getIdents;

- (PMKPromise*) readIdent:(NSString*)id;

@end
