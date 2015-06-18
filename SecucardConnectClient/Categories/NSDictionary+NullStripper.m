//
//  NSDictionary+NullStripper.m
//  Pods
//
//  Created by Jörn Schmidt on 10.06.15.
//
//

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
