//
//  SCAccountDevicesService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAccountDevicesService.h"
#import "SCGeneralAccountDevice.h"

@implementation SCAccountDevicesService

+ (SCAccountDevicesService*)sharedService
{
  static SCAccountDevicesService *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    
    instance = [SCAccountDevicesService new];
    instance.registeredEventClasses = @[[SCGeneralAccountDevice class]];
    
  });
  
  return instance;
}


@end
