//
//  SCAccountDevicesService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"

@interface SCAccountDevicesService : SCAbstractService

/**
 *  get instance of service
 *
 *  @return the singleton instance
 */
+ (SCAccountDevicesService*)sharedService;

@end
