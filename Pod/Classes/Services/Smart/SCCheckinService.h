//
//  SCCheckinService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"

@interface SCCheckinService : SCAbstractService

- (void) getCheckins:(void (^)(NSArray *, NSError *))handler;

- (void) getCheckinsList:(void (^)(SCObjectList *, NSError *))handler;

@end
