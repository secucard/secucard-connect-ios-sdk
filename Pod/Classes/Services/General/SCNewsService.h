//
//  SCNewsService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCObjectList.h"

@interface SCNewsService : SCAbstractService

/**
 *  get instance of service
 *
 *  @return the singleton instance
 */
+ (SCNewsService*)sharedService;

/**
 *  Retrieve a list of news
 *
 *  @param queryParams the search parameters
 *
 *  @return a promise which resolves to SCObjectList
 */
- (void) getNews:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *, NSError *))handler;

/**
 *  mark a news remotely as read
 *
 *  @param pid the news' id
 *
 *  @return a promise which resolves to nil
 */
- (void) markRead:(NSString*)pid  completionHandler:(void (^)(bool success, NSError *))handler;
  
@end
