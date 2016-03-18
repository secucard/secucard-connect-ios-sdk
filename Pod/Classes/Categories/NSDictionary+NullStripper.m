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

#import "NSDictionary+NullStripper.h"
#import "NSArray+NullStripper.h"

@implementation NSDictionary (NullStripper)

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks {
  const NSMutableDictionary *replaced = [self mutableCopy];
  const id nul = [NSNull null];
  
  for (NSString *key in self) {
    id object = [self objectForKey:key];
    if (object == nul) [replaced removeObjectForKey:key];
    else if ([object isKindOfClass:[NSDictionary class]]) [replaced setObject:[object dictionaryByReplacingNullsWithBlanks] forKey:key];
    else if ([object isKindOfClass:[NSArray class]]) [replaced setObject:[object arrayByReplacingNullsWithBlanks] forKey:key];
  }
  return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}

@end
