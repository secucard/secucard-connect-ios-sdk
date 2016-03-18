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

#import "SCGlobals.h"

#import "SCClientCredentials.h"
#import "SCUserCredentials.h"

#import "SCRestConfiguration.h"
#import "SCStompConfiguration.h"

@interface SCClientConfiguration : NSObject

@property (nonatomic, retain) SCRestConfiguration *restConfiguration;
@property (nonatomic, retain) SCStompConfiguration *stompConfiguration;
@property (nonatomic, assign) ServiceChannel defaultChannel;
@property (nonatomic, assign) BOOL stompEnabled;
@property (nonatomic, retain) NSString *oauthUrl;
@property (nonatomic, retain) SCClientCredentials *clientCredentials;
@property (nonatomic, retain) SCUserCredentials *userCredentials;
@property (nonatomic, retain) NSString *deviceId;
@property (nonatomic, retain) NSString *authType;

- (instancetype) initWithRestConfiguration:(SCRestConfiguration*)restConfig stompConfiguration:(SCStompConfiguration*)stompConfig defaultChannel:(ServiceChannel)defaultChannel stompEnabled:(BOOL)stompEnabled oauthUrl:(NSString*)oauthUrl clientCredentials:(SCClientCredentials*)clientCredentials userCredentials:(SCUserCredentials*)userCredentials deviceId:(NSString*)deviceId authType:(NSString*)authType;

@end
