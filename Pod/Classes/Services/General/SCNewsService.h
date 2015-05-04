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
 *  Retrieve a list of news
 *
 *  @param queryParams the search parameters
 *
 *  @return a promise which fulfills to SCObjectList
 */
- (PMKPromise*) getNews:(SCQueryParams*)queryParams;

/**
 *  mark a news remotely as read
 *
 *  @param pid the news' id
 *
 *  @return a promise which fulfills to nil
 */
- (PMKPromise*) markRead:(NSString*)pid;
  
@end
