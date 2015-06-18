//
//  NSArray+NullStripper.m
//  Pods
//
//  Created by Jörn Schmidt on 10.06.15.
//
//

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
