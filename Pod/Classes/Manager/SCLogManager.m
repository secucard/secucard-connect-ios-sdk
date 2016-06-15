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

#import "SCLogManager.h"

@implementation SCLogMessage

+ (instancetype) initWithLevel:(SCLogLevel)level Message:(NSString*)message error:(SecuError*)error {

  SCLogMessage *logMessage = [SCLogMessage new];
  logMessage.level = level;
  logMessage.message = message;
  
  if (error != nil) {
    logMessage.error = error;
  }
  
  return logMessage;
}

@end

@implementation SCLogManager

/**
 *  Shared manager as singleton
 *
 *  @return the manager instance
 */
+ (SCLogManager *)sharedManager
{
  static SCLogManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCLogManager new];
  });
  
  return instance;
}

+ (void) warn:(NSString*)message {
  
  SCLogMessage *logMessage = [SCLogMessage initWithLevel:LogLevelWarning Message:message error:nil];
  
  SCLogManager *manager = [SCLogManager sharedManager];
  if ([manager.delegate respondsToSelector:@selector(logManagerHandleLogging:)]) {
    [manager.delegate logManagerHandleLogging:logMessage];
  }
  
}

+ (void) info:(NSString*)message {
  
  SCLogMessage *logMessage = [SCLogMessage initWithLevel:LogLevelInfo Message:message error:nil];
  
  SCLogManager *manager = [SCLogManager sharedManager];
  if ([manager.delegate respondsToSelector:@selector(logManagerHandleLogging:)]) {
    [manager.delegate logManagerHandleLogging:logMessage];
  }
  
}

+ (SecuError*) makeErrorWithCode:(SCErrorType)code {
  NSDictionary *details = @{NSLocalizedDescriptionKey:[SCLogManager descriptionByCode:code]};
  return [SecuError errorWithDomain:kSCErrorDomain code:code userInfo:details];
}

+ (SecuError*) makeErrorWithCode:(SCErrorType)code andDomain:(NSString*) errorDomain {
  NSDictionary *details = @{NSLocalizedDescriptionKey: [SCLogManager descriptionByCode:code]};
  return [SecuError errorWithDomain:errorDomain code:code userInfo:details];
}

+ (SecuError*) makeErrorWithDescription:(NSString*)description {
  NSDictionary *details = @{NSLocalizedDescriptionKey: description};
  SecuError *error = [SecuError errorWithDomain:kSCErrorDomain code:ERR_UNDEFINED userInfo:details];
  error.scErrorUser = description;
  return error;
}

+ (SecuError*) makeErrorWithDescription:(NSString*)description andDomain:(NSString*) errorDomain {
  NSDictionary *details = @{NSLocalizedDescriptionKey: description};
  SecuError *error = [SecuError errorWithDomain:errorDomain code:ERR_UNDEFINED userInfo:details];
  error.scErrorUser = description;
  return error;
}

+ (void) error:(SecuError*)error {

  SCLogMessage *message;
  if (error.localizedDescription != nil) {
    message = [SCLogMessage initWithLevel:LogLevelError Message:error.localizedDescription error:error];
  } else {
    message = [SCLogMessage initWithLevel:LogLevelError Message:@"" error:error];
  }
  
  
  SCLogManager *manager = [SCLogManager sharedManager];
  if ([manager.delegate respondsToSelector:@selector(logManagerHandleLogging:)]) {
    [manager.delegate logManagerHandleLogging:message];
  }
  
  NSLog(@"Error: %@", error.errorString);
  
}

+ (void) errorWithDescription:(NSString*)description {
  [SCLogManager error:[SCLogManager makeErrorWithDescription:description]];
}

//ERR_UNDEFINED = -1,
//ERR_NO_ERROR,
//ERR_TOKEN,
//ERR_TOKEN_POLL_EXPIRED,
//ERR_LOCATIONING_NOT_ENABLED,
//ERR_LOCATIONING_NOT_AUTHORIZED_YET,
//ERR_LOCATIONING_NOT_AUTHORIZED,
//ERR_LOCATIONING_COULD_NOT_LOCATE,
//ERR_NOT_IMPLEMENTED,
//ERR_NEED_IMPLEMENTATION_IN_SUBCLASS,
//ERR_INVALID_RESULT,

+ (NSString*) descriptionByCode:(SCErrorType)code {
  
  switch (code) {
      
    case ERR_UNDEFINED:
      return @"Undefined Error";
      
    case ERR_TOKEN:
      return @"Problem with token";
      
    case ERR_TOKEN_POLL_EXPIRED:
      return @"Token polling expired";
      
    case ERR_LOCATIONING_NOT_ENABLED:
      return @"Locationing not enabled";
      
    case ERR_LOCATIONING_NOT_AUTHORIZED_YET:
      return @"Locationing is not authorized yet";
      
    case ERR_LOCATIONING_NOT_AUTHORIZED:
      return @"Locationing is not authorized";
      
    case ERR_LOCATIONING_COULD_NOT_LOCATE:
      return @"Locationing could not locate";
      
    case ERR_NOT_IMPLEMENTED:
      return @"Not Implemented";
    
    case ERR_NEED_IMPLEMENTATION_IN_SUBCLASS:
      return @"No implementation in sublass";
      
    case ERR_INVALID_RESULT:
      return @"Result is invalid";
    default:
      return [NSString stringWithFormat:@"ERROR: %d", code];
  }
  
}

@end
