//
//  SCRestServiceConfiguration.h
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import <Foundation/Foundation.h>

/**
 *  The RestConfiguration holds all needed data to connect appropriately to the API via Rest Calls
 */
@interface SCRestConfiguration : NSObject

/**
 *  The base URL to the api
 */
@property (nonatomic, retain, readonly) NSString *baseUrl;

/**
 *  the auth url which is different as it is not secured with token
 */
@property (nonatomic, retain, readonly) NSString *authUrl;

/**
 *  instantiation
 *
 *  @param baseUrl the base url to the api
 *  @param authUrl the authentiaction bas url
 *
 *  @return the configuration instance
 */
- (instancetype) initWithBaseUrl:(NSString*)baseUrl andAuthUrl:(NSString*)authUrl;

@end

