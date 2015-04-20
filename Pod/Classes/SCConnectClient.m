//
//  SecucardAppCore.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 19.08.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCConnectClient.h"
#import <CocoaLumberjack/DDASLLogger.h>
#import <CocoaLumberjack/DDTTYLogger.h>
#import <CocoaLumberjack/DDFileLogger.h>
#import <CocoaLumberjack/DDLog.h>

@implementation SCConnectClient

+ (SCConnectClient *)sharedInstance
{
  static SCConnectClient *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCConnectClient new];
  });
  
  return instance;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    
    // Logging
    
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    UIColor *green = [UIColor colorWithRed:(140/255.0) green:(205/255.0) blue:(27/255.0) alpha:1.0];
    [[DDTTYLogger sharedInstance] setForegroundColor:green backgroundColor:nil forFlag:DDLogFlagInfo];
    
    UIColor *blue = [UIColor colorWithRed:(77/255.0) green:(112/255.0) blue:(201/255.0) alpha:1.0];
    [[DDTTYLogger sharedInstance] setForegroundColor:blue backgroundColor:nil forFlag:DDLogFlagDebug];
    
    UIColor *grey = [UIColor colorWithRed:(162/255.0) green:(162/255.0) blue:(162/255.0) alpha:1.0];
    [[DDTTYLogger sharedInstance] setForegroundColor:grey backgroundColor:nil forFlag:DDLogFlagVerbose];
    
    DDFileLogger *fileLogger = [DDFileLogger new];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    
    [DDLog addLogger:fileLogger];

  }
  return self;
}




@end
