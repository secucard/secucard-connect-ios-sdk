//
//  SCAppDestination.m
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import "SCAppDestination.h"
#import "SCStompManager.h"

@implementation SCAppDestination

+ (instancetype) initWithCommand:(NSString*)command type:(Class)type method:(NSString*)method {
  
  SCAppDestination *destination = [SCAppDestination new];
  
  destination.command = command;
  destination.type = type;
  destination.method = method;
  
  return destination;
  
}

+ (instancetype) initWithAppId:(NSString *)appId method:(NSString*)method {
  
  SCAppDestination *appDest = [SCAppDestination initWithCommand:nil type:nil method:method];
  appDest.appId = appId;
  return appDest;
  
}

- (NSString *)destination {
  return [NSString stringWithFormat:@"%@%@%@", [SCStompManager sharedManager].configuration.basicDestination, kStompDestinationPrefix, self.method];
}

@end