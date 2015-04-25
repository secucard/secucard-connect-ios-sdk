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
  ERR_LOCATIONING_NOT_ENABLED,
  ERR_LOCATIONING_NOT_AUTHORIZED_YET,
  ERR_LOCATIONING_NOT_AUTHORIZED,
  ERR_LOCATIONING_COULD_NOT_LOCATE
  
} SCErrorType;

@interface SCErrorManager : NSObject

+ (NSError*) errorWithCode:(SCErrorType)code;
+ (NSError*) errorWithCode:(SCErrorType)code andDomain:(NSString*) errorDomain;
+ (NSError*) errorWithDescription:(NSString*)description;
+ (NSError*) errorWithDescription:(NSString*)description andDomain:(NSString*) errorDomain;

+ (void) handleError:(NSError*)error;
+ (void) handleErrorWithDescription:(NSString*)description;

@end
