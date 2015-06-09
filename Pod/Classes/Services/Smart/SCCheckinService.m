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
  });
  
  return instance;
}

- (void)getCheckins:(void (^)(NSArray *, NSError *))handler {
  
  [self getList:[SCSmartCheckin class] withParams:nil onChannel:PersistentChannel completionHandler:handler];
  
}

- (void) getCheckinsList:(void (^)(SCObjectList *, NSError *))handler {

  [self getObjectList:[SCSmartCheckin class] withParams:nil onChannel:PersistentChannel completionHandler:handler];
  
}

- (void)postProcessObjects:(NSArray *)list completionHandler:(void (^)(NSArray *, NSError *))handler {
  
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
