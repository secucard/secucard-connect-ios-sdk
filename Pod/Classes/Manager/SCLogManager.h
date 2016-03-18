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
#import "SecuError.h"
#define kSCErrorDomain @"SCSecucardCore"


typedef enum {
  
  ERR_UNDEFINED = -1,
  ERR_NO_ERROR,
  ERR_TOKEN,
  ERR_TOKEN_POLL_EXPIRED,
  ERR_LOCATIONING_NOT_ENABLED,
  ERR_LOCATIONING_NOT_AUTHORIZED_YET,
  ERR_LOCATIONING_NOT_AUTHORIZED,
  ERR_LOCATIONING_COULD_NOT_LOCATE,
  ERR_NOT_IMPLEMENTED,
  ERR_NEED_IMPLEMENTATION_IN_SUBCLASS,
  ERR_INVALID_RESULT,
  
} SCErrorType;

typedef enum {
  
  LogLevelError,
  LogLevelWarning,
  LogLevelInfo
  
} SCLogLevel;

@interface SCLogMessage : NSObject

+ (instancetype) initWithLevel:(SCLogLevel)level Message:(NSString*)message error:(NSError*)error;

@property (nonatomic, assign) SCLogLevel level;
@property (nonatomic, retain) NSDate *created;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) SecuError *error;

@end

@protocol SCLogManagerDelegate <NSObject>

- (void) logManagerHandleLogging:(SCLogMessage*)message;

@end

@interface SCLogManager : NSObject

@property (nonatomic, retain) id<SCLogManagerDelegate> delegate;

+ (SCLogManager *)sharedManager;

+ (SecuError*) makeErrorWithCode:(SCErrorType)code;
+ (SecuError*) makeErrorWithCode:(SCErrorType)code andDomain:(NSString*) errorDomain;
+ (SecuError*) makeErrorWithDescription:(NSString*)description;
+ (SecuError*) makeErrorWithDescription:(NSString*)description andDomain:(NSString*) errorDomain;

+ (void) warn:(NSString*)message;
+ (void) info:(NSString*)message;

+ (void) error:(SecuError*)error;
+ (void) errorWithDescription:(NSString*)description;

@end
