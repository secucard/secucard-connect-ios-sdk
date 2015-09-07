//
//  SCStompDestination.m
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import "SCStompDestination.h"
#import "SCStompManager.h"

@implementation SCStompDestination

- (NSString *)destination {
  
  NSString *dest = [NSString stringWithFormat:@"%@%@", [SCStompManager sharedManager].configuration.basicDestination, kStompDestinationPrefix];
  
  dest = [dest stringByAppendingString:self.command];
  
  if (self.type) {
    dest = [dest stringByAppendingString:[[self.type object] lowercaseString]];                 // -> general.publicmerchants
  }
  
  if (self.method) {
    dest = [dest stringByAppendingString:@"."];
    dest = [dest stringByAppendingString:self.method];
  }
  
  return dest;
  
}

+ (instancetype) initWithCommand:(NSString*)command {
  return [self initWithCommand:command type:nil method:nil];
}

+ (instancetype) initWithCommand:(NSString*)command type:(Class)type {
  return [self initWithCommand:command type:type method:nil];
}

+ (instancetype) initWithCommand:(NSString*)command type:(Class)type method:(NSString*)method {
  
  SCStompDestination *destination = [SCStompDestination new];
  
  destination.command = command;
  destination.type = type;
  destination.method = method;
  
  return destination;
  
}

@end