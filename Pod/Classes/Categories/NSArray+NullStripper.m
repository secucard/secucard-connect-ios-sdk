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

#import "NSArray+NullStripper.h"
#import "NSDictionary+NullStripper.h"

@implementation NSArray (NullStripper)

- (NSArray *)arrayByReplacingNullsWithBlanks  {
  NSMutableArray *replaced = [self mutableCopy];
  const id nul = [NSNull null];
  for (int idx = 0; idx < [replaced count]; idx++) {
    id object = [replaced objectAtIndex:idx];
    if (object == nul) [replaced removeObjectAtIndex:idx];
    else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object dictionaryByReplacingNullsWithBlanks]];
    else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[object arrayByReplacingNullsWithBlanks]];
  }
  return [replaced copy];
}

@end
