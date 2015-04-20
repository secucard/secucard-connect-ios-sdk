//
//  SCAccessabilityManager.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 09.10.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Reachability/Reachability.h>
#import <UIKit/UIKit.h>

#define kErrorDomainSCAccessability                 @"SCSecucardCoreAccessability"

/**
 Accessability Type
 */
typedef enum AccessibilityType {
  AccessibleWithOnlyWIFI,
  AccessibleWithEvenCell
} AccessibilityType;

@interface SCAccessabilityManager : NSObject

@property (nonatomic, assign) AccessibilityType accessibleWith;

+ (SCAccessabilityManager *)sharedManager;

- (void) watchConnection;
- (void) addAccessibleBlock:(NetworkReachable)reachableBlock;
- (void) addUnaccessibleBlock:(NetworkUnreachable)unreachableBlock;

- (void) watchNetwork:(NSString*)urlString onSuccess:(NetworkReachable)reachableBlock onError:(NetworkUnreachable)unreachableBlock;
- (void) unwatchAllNetworks;
- (void) watchAllNetworks;

- (BOOL) isWifi;
- (BOOL) isOff;

@end
