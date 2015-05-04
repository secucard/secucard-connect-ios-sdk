//
//  SCIdentService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCServicesIdentRequest.h"

@interface SCIdentService : SCAbstractService

/**
 *  get the service's singleton instance
 *
 *  @return the instance
 */
+ (SCIdentService*)sharedService;

/**
 * TODO: Set to true/false to globally enable/disable attachment caching when requested by methods of this service.
 * Caching is enabled by default but is only performed when requested in methods.
 */
//- (void) cacheAttachments:(BOOL)cacheAttachments;

/**
 *  Returns a list of ident request objects according to the given query parameters.
 *
 *  @param queryParams the search paramters
 *
 *  @return a promise fulfilling with NSArray of SCServicesIdentRequest
 */
- (PMKPromise*) getIdentRequests:(SCQueryParams*)queryParams;
    
/**
 *  Returns a single ident request object.
 *
 *  @param id the ident's id
 *
 *  @return a promise fulfilling with SCServicesIdentRequest
 */
- (PMKPromise*) getIdentRequest:(NSString*)id;
      
/**
 *  Returns a ident result for a given list of ident request ids.
 *
 *  @param identRequestIds     an array of ident request ids
 *  @param downloadAttachments whether to download attachments
 *
 *  @return a promise fulfilling with NSArray of SCServicesIdentRequest
 */
- (PMKPromise*) getIdentResultsByRequestIds:(NSArray*)identRequestIds downloadAttachments:(BOOL)downloadAttachments;

/**
 *  Returns a list of raw results for a given list of ident request ids.
 *
 *  @param requestIds          an array of ident request ids
 *  @param downloadAttachments whether to download attachments
 *
 *  @return a promise fulfilling with NSArray of SCServicesIdentRequest
 */
- (PMKPromise*) getIdentResultsByRequestsRaw:(NSArray*)requestIds downloadAttachments:(BOOL)downloadAttachments;
          
/**
 *  Creates a new ident request.
 *
 *  @param newIdentRequest the new ident request
 *
 *  @return a promise fulfilling with the new SCServicesIdentRequest
 */
- (PMKPromise*) createIdentRequest:(SCServicesIdentRequest*)newIdentRequest;
            
/**
 *  Returns a list of ident result objects according to the given query parameters.
 *  Supports also the optional download and caching of all attachments before returning.
 *  This will speed up clients access to them but involves increasing memory usage.
 *
 *  @param queryParams         A set of parameters a ident result must match.
 *  @param callback            Callback for asynchronous handling.
 *  @param downloadAttachments Set to true if attachments should be completely downloaded before returning.
 *                              Note: Depending on the number of returned results + persons + attachments this may be a lot!
 *                              Works only if {@link #cacheAttachments(boolean)} is set to true, which is the default.
 *
 * @return a promise fulfilling with an NSArray of SCServicesIdentRequest
 */
- (PMKPromise*) getIdentResults:(SCQueryParams*)queryParams downloadAttachments:(BOOL)downloadAttachments;

/**
 * Returns a single ident result object.
 *
 * @param id                  The id
 * @param callback            Callback for asynchronous handling.
 * @param downloadAttachments Set to true if attachments should be completely downloaded before returning.
 *                            Note: Depending on the number of returned persons + attachments this may be a lot!
 *                            Works only if cacheAttachments is set to true, which is the default.
 *
 * @return a promise fulfilling with SCServicesIdentRequest
 */
- (PMKPromise*) getIdentResult:(NSString*)id downloadAttachments:(BOOL)downloadAttachments;


@end
