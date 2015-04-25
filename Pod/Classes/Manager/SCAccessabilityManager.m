//
//  SCAccessabilityManager.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 09.10.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCAccessabilityManager.h"

@interface SCAccessabilityManager()

@property (nonatomic, retain) NSMutableArray *reaches;
@property (nonatomic, retain) NSMutableArray *reachableBlocks;
@property (nonatomic, retain) NSMutableArray *unreachableBlocks;

@property (nonatomic, retain) Reachability *generalReach;

@end

@implementation SCAccessabilityManager

+ (SCAccessabilityManager *)sharedManager
{
  static SCAccessabilityManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [SCAccessabilityManager new];
  });
  
  return instance;
}

- (id) init
{
  self = [super init];
  if (self)
  {
    self.reaches = [NSMutableArray new];
    self.reachableBlocks = [NSMutableArray new];
    self.unreachableBlocks = [NSMutableArray new];
    self.accessibleWith = AccessibleWithEvenCell;
  }
  return self;
}

/**
 *  Watch the general connection to the internt. You can add blocks to be notified later on.
 */
- (void) watchConnection
{
  self.generalReach = [Reachability reachabilityForInternetConnection];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
  
  __weak typeof(self) weakSelf = self;
  self.generalReach.reachableBlock = ^(Reachability *reach) {
    for (NetworkReachable reachableBlock in weakSelf.reachableBlocks) {
      reachableBlock(reach);
    }
  };
  
  self.generalReach.unreachableBlock = ^(Reachability *reach) {
    for (NetworkUnreachable unreachableBlock in weakSelf.unreachableBlocks) {
      unreachableBlock(reach);
    }
  };
  
  self.generalReach.reachableOnWWAN = (_accessibleWith == AccessibleWithOnlyWIFI) ? NO : YES;
  
  [self.generalReach startNotifier];
  
}

/**
 *  Is Wifi on
 *
 *  @return wifi state
 */
- (BOOL) isWifi
{
  return (self.generalReach.currentReachabilityStatus == ReachableViaWiFi);
}

/**
 *  is any connection off
 *
 *  @return connection state, off is true
 */
- (BOOL) isOff
{
  return (self.generalReach.currentReachabilityStatus == NotReachable);
}

/**
 *  Notification handler for network state change
 *
 *  @param notification the notification sent by reachability
 */
- (void) reachabilityDidChange:(NSNotification*)notification
{
  
  // At first, just send to display
  // TODO: [SCNotificationManager sendNotificationToDisplay:[NSString stringWithFormat:@"Network did change: %@", self.generalReach.currentReachabilityString]];

}

/**
 *  add a block to be called when the network status has changed to accessible
 *
 *  @param reachableBlock the block
 */
- (void) addAccessibleBlock:(NetworkReachable)reachableBlock
{
  
  // create if not ceated yet
  if (!self.generalReach)
    [self watchConnection];
  
  [self.reachableBlocks addObject:reachableBlock];
}

/**
 *  add a block to be called when the network status has changed to unaccessible
 *
 *  @param unreachableBlock the block
 */
- (void) addUnaccessibleBlock:(NetworkUnreachable)unreachableBlock
{
  // create if not ceated yet
  if (!self.generalReach)
    [self watchConnection];
  
  [self.unreachableBlocks addObject:unreachableBlock];
}

/**
 *  tell manager to set its reaches to WIFI-only or not
 *
 *  @param accessibleWith Teh AccessibilityType
 */
- (void) setAccessibleWith:(AccessibilityType)accessibleWith
{
  
  _accessibleWith = accessibleWith;
  
  for (Reachability *reach in self.reaches) {
    reach.reachableOnWWAN = (accessibleWith == AccessibleWithOnlyWIFI) ? NO : YES;
  }
  if (self.generalReach)
    self.generalReach.reachableOnWWAN = (accessibleWith == AccessibleWithOnlyWIFI) ? NO : YES;
  
}

/**
 *  watch a network, return the Reachability object to include further configuration such as sensitivity and blocks
 *
 *  @param urlString the url to be watched
 *
 *  @return Reachabilty object
 */
- (void) watchNetwork:(NSString*)urlString onSuccess:(NetworkReachable)reachableBlock onError:(NetworkUnreachable)unreachableBlock
{
  Reachability *reach = [Reachability reachabilityWithHostname:urlString];
  
  // preset blocks
  reach.reachableBlock = reachableBlock;
  reach.unreachableBlock = unreachableBlock;
  
  // check if available with 3G, etc.
  reach.reachableOnWWAN = (_accessibleWith == AccessibleWithOnlyWIFI) ? NO : YES;
  
  [self.reaches addObject:reach];
  
}

/**
 *  unwatch all reaches, just suspends watching
 */
- (void) unwatchAllNetworks
{
  for (Reachability *reach in self.reaches)
  {
    [reach stopNotifier];
  }
  if (self.generalReach)
    [self.generalReach stopNotifier];
}

/**
 *  watch all reaches, just removes suspension
 */
- (void) watchAllNetworks
{
  for (Reachability *reach in self.reaches)
  {
    [reach startNotifier];
  }
  if (self.generalReach)
    [self.generalReach startNotifier];
}

@end
