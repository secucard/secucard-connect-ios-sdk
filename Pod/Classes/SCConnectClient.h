//
//  SecucardAppCore.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 19.08.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <CocoaLumberjack/DDASLLogger.h>
#import <CocoaLumberjack/DDTTYLogger.h>
#import <CocoaLumberjack/DDFileLogger.h>
#import <CocoaLumberjack/DDLog.h>

#import "SCErrorManager.h"

#import "SCClientConfiguration.h"
#import "SCAbstractService.h"

@interface SCConnectClient : NSObject

@property (nonatomic, retain) SCClientConfiguration *configuration;
@property (nonatomic, assign) BOOL connected;


+ (SCConnectClient *)sharedInstance;

- (void) initWithConfiguration:(SCClientConfiguration*)configuration;
- (void) setUserCredentials:(NSString*)username password:(NSString*)password;
- (void) connect;
- (void) disconnect;

@end
