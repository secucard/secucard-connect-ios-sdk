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

- (PMKPromise*) getCheckins {
  return [self getList:[SCSmartCheckin class] withParams:nil onChannel:PersistentChannel];
}

- (PMKPromise*) getCheckinsList {
  return [self getObjectList:[SCSmartCheckin class] withParams:nil onChannel:PersistentChannel];
}

- (PMKPromise *)postProcessObjects:(NSArray *)list {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    for (NSObject *object in list) {
      
      SCMediaResource *picture = ((SCSmartCheckin*)object).pictureObject;
      if (picture) {
        if (!picture.isCached) {
          [picture download];
        }
      }
      
    }
    
  }];
}

@end
