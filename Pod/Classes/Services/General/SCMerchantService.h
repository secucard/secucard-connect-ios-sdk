//
//  SCMerchantService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"

@interface SCMerchantService : SCAbstractService

/**
 *  get instance of service
 *
 *  @return the singleton instance
 */
+ (SCMerchantService*)sharedService;

@end
