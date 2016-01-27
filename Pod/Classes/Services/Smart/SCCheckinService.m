//
//  SCCheckinService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCCheckinService.h"
#import "SCSmartCheckin.h"

@implementation SCCheckinService

/**
 *  get instance of service
 *
 *  @return the singleton instance
 */
+ (SCCheckinService*)sharedService
{
  static SCCheckinService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    
    instance = [SCCheckinService new];
    
    instance.registeredEventClasses = @[[SCSmartCheckin class]];
    
  });
  
  return instance;
}

- (void)getCheckins:(void (^)(NSArray *, SecuError *))handler {
  
  [SCLogManager info:@"CONNECT-SDK: getCheckins"];
  
  [self getList:[SCSmartCheckin class] withParams:nil onChannel:PersistentChannel completionHandler:handler];
  
}

- (void) getCheckinsList:(void (^)(SCObjectList *, SecuError *))handler {

  [SCLogManager info:@"CONNECT-SDK: getCheckinsList"];
  
  [self getObjectList:[SCSmartCheckin class] withParams:nil onChannel:PersistentChannel completionHandler:handler];
  
}

- (void)postProcessObjects:(NSArray *)list completionHandler:(void (^)(NSArray *, SecuError *))handler {
  
  for (NSObject *object in list) {
    
    SCMediaResource *picture = ((SCSmartCheckin*)object).pictureObject;
    if (picture) {
      if (!picture.isCached) {
        [picture download];
      }
    }
    
  }
  
  handler(list, nil);
}

@end
