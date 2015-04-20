//
//  PublicMerchantService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>
#import "SCAbstractService.h"

@interface SCPublicMerchantService : SCAbstractService

- (PMKPromise*) getPublicMerchant:(NSString*)id;
- (PMKPromise*) getPublicMerchants:(SCQueryParams*)params;

@end
