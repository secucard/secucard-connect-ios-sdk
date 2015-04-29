//
//  SecucardAppCore.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 19.08.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SCErrorManager.h"
#import "SCClientConfiguration.h"
#import "SCAbstractService.h"

@class SCClientConfiguration;
@class SCUserCredentials;

@interface SCConnectClient : NSObject

@property (nonatomic, retain) SCClientConfiguration *configuration;
@property (nonatomic, assign) BOOL connected;


+ (SCConnectClient *)sharedInstance;


- (instancetype) initWithConfiguration:(SCClientConfiguration*)configuration;
- (void) setUserCredentials:(SCUserCredentials*)userCredentials;
- (PMKPromise*) connect;
- (PMKPromise*) disconnect;

@end
