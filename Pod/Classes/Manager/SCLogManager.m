//
//  DVDErrorManager.m
//  8mal8
//
//  Created by Jörn Schmidt on 11.03.15.
//  Copyright (c) 2015 DeviD. All rights reserved.
//

#import "SCLogManager.h"

@implementation SCLogMessage

+ (instancetype) initWithLevel:(SCLogLevel)level Message:(NSString*)message error:(NSError*)error {

  SCLogMessage *logMessage = [SCLogMessage new];
  logMessage.level = level;
  logMessage.message = message;
  logMessage.error = error;
  
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

+ (NSError*) makeErrorWithCode:(SCErrorType)code {
  NSDictionary *details = @{NSLocalizedDescriptionKey: [SCLogManager descriptionByCode:code]};
  return [NSError errorWithDomain:kSCErrorDomain code:code userInfo:details];
}

+ (NSError*) makeErrorWithCode:(SCErrorType)code andDomain:(NSString*) errorDomain {
  NSDictionary *details = @{NSLocalizedDescriptionKey: [SCLogManager descriptionByCode:code]};
  return [NSError errorWithDomain:errorDomain code:code userInfo:details];
}

+ (NSError*) makeErrorWithDescription:(NSString*)description {
  NSDictionary *details = @{NSLocalizedDescriptionKey: description};
  return [NSError errorWithDomain:kSCErrorDomain code:ERR_UNDEFINED userInfo:details];
}

+ (NSError*) makeErrorWithDescription:(NSString*)description andDomain:(NSString*) errorDomain {
  NSDictionary *details = @{NSLocalizedDescriptionKey: description};
  return [NSError errorWithDomain:errorDomain code:ERR_UNDEFINED userInfo:details];
}

+ (void) error:(NSError*)error {
  
  SCLogMessage *message = [SCLogMessage initWithLevel:LogLevelError Message:error.localizedDescription error:error];
  
  SCLogManager *manager = [SCLogManager sharedManager];
  if ([manager.delegate respondsToSelector:@selector(logManagerHandleLogging:)]) {
    [manager.delegate logManagerHandleLogging:message];
  }
  
  NSLog(@"Error: %@", error.localizedDescription);
  
}

+ (void) errorWithDescription:(NSString*)description {
  [SCLogManager error:[SCLogManager makeErrorWithDescription:description]];
}

+ (NSString*) descriptionByCode:(SCErrorType)code {
  
  switch (code) {
    case ERR_LOCATIONING_COULD_NOT_LOCATE:
      return @"error.couldNotLocate";
      
    case ERR_NOT_IMPLEMENTED:
      return @"Not Implemented";
    
    case ERR_INVALID_RESULT:
      return @"Result is invalid";
    default:
      return [NSString stringWithFormat:@"ERROR: %d", code];
  }
  
}

@end
