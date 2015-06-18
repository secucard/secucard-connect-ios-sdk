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

#import "SCLogManager.h"
#import "SCAbstractService.h"
#import "SCAccountService.h"

#import "SCUserCredentials.h"

@interface SCConnectClient : NSObject

@property (nonatomic, retain) SCClientConfiguration *configuration;
@property (nonatomic, assign) BOOL connected;

+ (SCConnectClient *)sharedInstance;

- (void) initWithConfiguration:(SCClientConfiguration*)configuration;
- (void) setUserCredentials:(SCUserCredentials*)userCredentials;
- (void) connect:(void (^)(bool, NSError *))handler;
- (void) disconnect:(void (^)(bool, NSError *))handler;
- (void) destroy:(void (^)(bool, NSError *))handler;

@end
