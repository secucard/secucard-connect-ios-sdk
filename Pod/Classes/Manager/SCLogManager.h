//
//  DVDErrorManager.h
//  8mal8
//
//  Created by Jörn Schmidt on 11.03.15.
//  Copyright (c) 2015 DeviD. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@property (nonatomic, retain) NSError *error;

@end

@protocol SCLogManagerDelegate <NSObject>

- (void) logManagerHandleLogging:(SCLogMessage*)message;

@end

@interface SCLogManager : NSObject

@property (nonatomic, retain) id<SCLogManagerDelegate> delegate;

+ (SCLogManager *)sharedManager;

+ (NSError*) makeErrorWithCode:(SCErrorType)code;
+ (NSError*) makeErrorWithCode:(SCErrorType)code andDomain:(NSString*) errorDomain;
+ (NSError*) makeErrorWithDescription:(NSString*)description;
+ (NSError*) makeErrorWithDescription:(NSString*)description andDomain:(NSString*) errorDomain;

+ (void) warn:(NSString*)message;
+ (void) info:(NSString*)message;

+ (void) error:(NSError*)error;
+ (void) errorWithDescription:(NSString*)description;

@end
