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
#import <UIKit/UIKit.h>

#import "SCClientConfiguration.h"

#import "SCLogManager.h"
#import "SCAbstractService.h"
#import "SCAccountService.h"

#import "SCUserCredentials.h"

@interface SCConnectClient : NSObject

@property (nonatomic, retain) SCClientConfiguration *configuration;
@property (nonatomic, assign) BOOL connected;
@property (nonatomic, assign) BOOL isConnecting;
@property (nonatomic, assign) BOOL initialized;

+ (SCConnectClient *)sharedInstance;

- (NSString*) myApiVersion;

- (void) initWithConfiguration:(SCClientConfiguration*)configuration;
- (void) setUserCredentials:(SCUserCredentials*)userCredentials;
- (void) connect:(void (^)(bool, SecuError *))handler;
- (void) disconnect:(void (^)(bool, SecuError *))handler;
- (void) logoff:(void (^)(bool, SecuError *))handler;
- (void) destroy:(void (^)(bool, SecuError *))handler;

@end
