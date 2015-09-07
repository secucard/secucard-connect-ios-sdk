
//
//  SCSecuObject.m
//  Pods
//
//  Created by Jörn Schmidt on 13.04.15.
//
//

#import "SCSecuObject.h"
#import "SCLogManager.h"

@implementation SCSecuObject

+ (NSDateFormatter *)dateFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
  return dateFormatter;
}

+ (NSDateFormatter *)dateShortFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  dateFormatter.dateFormat = @"yyyy-MM-dd";
  return dateFormatter;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSString*) object {
  [SCLogManager error:[SCLogManager makeErrorWithCode:ERR_NEED_IMPLEMENTATION_IN_SUBCLASS]];
  return @"";
}

@end
