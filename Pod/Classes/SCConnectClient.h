//
//  SecucardAppCore.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 19.08.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SCClientConfiguration.h"
#import "SCAbstractService.h"

@interface SCConnectClient : NSObject

+ (SCConnectClient *)sharedInstance;

- (SCConnectClient *)createWithId:(NSString*)id andConfiguration:(SCClientConfiguration*)configuration;
- (void) setUserCredentials:(NSString*)username password:(NSString*)password;
- (SCAbstractService*) getServiceWithClass:(Class)serviceClass;
- (SCAbstractService*) getServiceWithId:(NSString*)serviceId;

@end
