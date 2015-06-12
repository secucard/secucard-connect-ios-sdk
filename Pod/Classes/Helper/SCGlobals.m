//
//  SCGlobals.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 29.10.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCGlobals.h"

@implementation SCGlobals

+ (NSError*) createErrorWithDescription:(NSString*)description {
  return [NSError errorWithDomain:@"com.secucard.app.core.ios.lib"
                                                   code:-1
                                               userInfo:@{@"description":description}];
}

+ (NSDateFormatter *)dateFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
  return dateFormatter;
}

@end
