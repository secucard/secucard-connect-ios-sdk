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
 *  @return a promise resolveing with NSArray
 */
- (void) getContainers:(SCQueryParams*)queryParams completionHandler:(void (^)(NSArray *, NSError *))handler;

/**
 *  create a container
 *
 *  @param container the container
 *
 *  @return a promise resolveing with the created container
 */
- (void) createContainer:(SCPaymentContainer*)container completionHandler:(void (^)(SCPaymentContainer *, NSError *))handler;

/**
 *  update a container
 *
 *  @param container the container to update
 *
 *  @return a promise resolveing with SCPaymentContainer
 */
- (void) updateContainer:(SCPaymentContainer*)container completionHandler:(void (^)(SCPaymentContainer *, NSError *))handler;

/**
 *  assigna container to a customer
 *
 *  @param containerId the container id
 *  @param customerId  the customer id
 *
 *  @return a promise resolveing with the updated SCPaymentContainer
 */
- (void) updateContainerAssignment:(NSString*)containerId customerId:(NSString*)customerId completionHandler:(void (^)(SCPaymentContainer *, NSError *))handler;

/**
 *  unassign a container from any customer
 *
 *  @param containerId the container id
 *
 *  @return a promise resolveing with nil
 */
- (void) deleteContainerAssignment:(NSString*)containerId completionHandler:(void (^)(bool success, NSError *))handler;

/**
 *  delete a container
 *
 *  @param id the container's id
 *
 *  @return a promise resolveing with nil
 */
- (void) deleteContainer:(NSString*)id completionHandler:(void (^)(bool success, NSError *))handler;

@end
