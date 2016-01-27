//
//  SCCheckinService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"

@interface SCCheckinService : SCAbstractService

+ (SCCheckinService*)sharedService;

- (void) getCheckins:(void (^)(NSArray *, SecuError *))handler;

- (void) getCheckinsList:(void (^)(SCObjectList *, SecuError *))handler;

@end
