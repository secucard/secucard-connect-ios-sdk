//
//  SCAbstractService.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>
#import <PromiseKit/PromiseKit.h>

#import "SCServiceManager.h"
#import "SCGlobals.h"

@interface SCAbstractService : NSObject <SCServiceManagerProtocol>

- (SCServiceManager*) serviceManagerByChannel:(ServiceChannel)channel;

@end
