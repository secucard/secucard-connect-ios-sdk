//
//  SCContainerService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCPaymentContainer.h"

@interface SCContainerService : SCAbstractService

/**
 *  get the service's singleton instance
 *
 *  @return the instance
 */
+ (SCContainerService*)sharedService;

/**
 *  retrieve container
 *
 *  @param queryParams the search paramters
 *
 *  @return a promise fulfilling with NSArray
 */
- (PMKPromise*) getContainers:(SCQueryParams*)queryParams;

/**
 *  create a container
 *
 *  @param container the container
 *
 *  @return a promise fulfilling with the created container
 */
- (PMKPromise*) createContainer:(SCPaymentContainer*)container;

/**
 *  update a container
 *
 *  @param container the container to update
 *
 *  @return a promise fulfilling with SCPaymentContainer
 */
- (PMKPromise*) updateContainer:(SCPaymentContainer*)container;

/**
 *  assigna container to a customer
 *
 *  @param containerId the container id
 *  @param customerId  the customer id
 *
 *  @return a promise fulfilling with the updated SCPaymentContainer
 */
- (PMKPromise*) updateContainerAssignment:(NSString*)containerId customerId:(NSString*)customerId;

/**
 *  unassign a container from any customer
 *
 *  @param containerId the container id
 *
 *  @return a promise fulfilling with nil
 */
- (PMKPromise*) deleteContainerAssignment:(NSString*)containerId;

/**
 *  delete a container
 *
 *  @param id the container's id
 *
 *  @return a promise fulfilling with nil
 */
- (PMKPromise*) deleteContainer:(NSString*)id;

@end
