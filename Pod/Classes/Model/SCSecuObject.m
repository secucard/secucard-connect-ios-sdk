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
