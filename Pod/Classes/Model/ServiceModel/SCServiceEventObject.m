//
//  SCServiceEventObject.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 13.11.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCServiceEventObject.h"

@implementation SCServiceEventObject

+ (id) initWithDictionary:(NSDictionary*)dictionary {
  
  SCServiceEventObject *event = [SCServiceEventObject new];
  
  event.id = [dictionary objectForKey:@"id"];
  event.type = [dictionary objectForKey:@"type"];
  event.data = [dictionary objectForKey:@"data"];

  return event;
  
}

@end
