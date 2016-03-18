/******************************************
 *
 *  Copyright (c) 2015. hp.weber GmbH & Co secucard KG (www.secucard.com)
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 ******************************************/

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

