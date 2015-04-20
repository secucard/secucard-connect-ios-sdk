//
//  DVDErrorManager.m
//  8mal8
//
//  Created by Jörn Schmidt on 11.03.15.
//  Copyright (c) 2015 DeviD. All rights reserved.
//

#import "SCErrorManager.h"

@implementation SCErrorManager

+ (NSError*) errorWithCode:(SCErrorType)code {
  NSDictionary *details = @{NSLocalizedDescriptionKey: [SCErrorManager descriptionByCode:code]};
  return [NSError errorWithDomain:kSCErrorDomain code:code userInfo:details];
}

+ (NSError*) errorWithCode:(SCErrorType)code andDomain:(NSString*) errorDomain {
  NSDictionary *details = @{NSLocalizedDescriptionKey: [SCErrorManager descriptionByCode:code]};
  return [NSError errorWithDomain:errorDomain code:code userInfo:details];
}

+ (NSError*) errorWithDescription:(NSString*)description {
  NSDictionary *details = @{NSLocalizedDescriptionKey: description};
  return [NSError errorWithDomain:kSCErrorDomain code:ERR_UNDEFINED userInfo:details];
}

+ (NSError*) errorWithDescription:(NSString*)description andDomain:(NSString*) errorDomain {
  NSDictionary *details = @{NSLocalizedDescriptionKey: description};
  return [NSError errorWithDomain:errorDomain code:ERR_UNDEFINED userInfo:details];
}


+ (NSString*) descriptionByCode:(SCErrorType)code {
  
  switch (code) {
    case ERR_LOCATIONING_COULD_NOT_LOCATE:
      return @"error.couldNotLocate";
      break;
      
    default:
      return [NSString stringWithFormat:@"ERROR: %d", code];
      break;
  }
  
}

@end
