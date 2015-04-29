//
//  SCGlobals.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 29.10.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>

// free
#define kShowSettings                         @"showSettings"
#define kShowProfile                          @"showProfile"
#define kCoreDidPostError                     @"coreDidPostError"
#define kStompMessageNotification             @"receivedStompMessage"
#define kNotifictaionCheckIdleState           @"notifictaionCheckIdleState"


// SERVICE CALLS

#define kAuthToken                            @"oauth/token"

#define kServiceBeaconEnvironment             @"General.Accounts.{pid}.BeaconEnvironment"

#define kServiceLocation                      @"General.Accounts.{pid}.Location"

#define kServiceGeneralMerchants              @"General.Merchants"
#define kServicePublicMerchants               @"General.PublicMerchants"
#define kServiceSkeletons                     @"General.Skeletons"
#define kServiceAccountsApns                  @"General.Accounts.{pid}.Apns"
#define kServiceTransactions                  @"General.Transactions"

#define kServiceBeaconMonitor                 @"Beacon.Monitor"


#define kParamData                            @"data"
#define kParamCount                           @"count"
#define kParamScrollId                        @"scroll_id"
#define kParamFields                          @"fields"
#define kParamScrollExpire                    @"scroll_expire"
#define kParamGeoLat                          @"geo[lat]"
#define kParamGeoLon                          @"geo[lon]"
#define kParamGeoField                        @"geo[field]"
#define kParamSort                            @"sort[%@]"
#define kParamDistance                        @"distance"
#define kParamAccessToken                     @"access_token"
#define kParamRefreshToken                    @"refresh_token"

typedef enum {
  
  RestChannel,
  StompChannel
  
} ServiceChannel;

@interface SCGlobals : NSObject

+ (NSError*) createErrorWithDescription:(NSString*)description;

@end
