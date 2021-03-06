//
//  SCGlobals.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 29.10.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

/******************************************
 *
 *  Copyright (c) 2015. hp.weber GmbH & Co secucard KG (www.secucard.com)
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 ******************************************/

#import <Foundation/Foundation.h>

// free
#define kShowSettings                         @"showSettings"
#define kShowProfile                          @"showProfile"
#define kCoreDidPostError                     @"coreDidPostError"
#define kStompMessageNotification             @"receivedStompMessage"
#define kNotifictaionCheckIdleState           @"notifictaionCheckIdleState"


// DEPRECATED: SERVICE CALLS

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


#define kGet @"get"
#define kAdd @"add"
#define kUpdate @"update"
#define kRemove @"remove"
#define kExecute @"execute"



/**
 * PRESET
 */
#define kPresetAccountRead @"account_read"
#define kPresetOwn @"own"

/**
 * PID constant
 */
#define kMe @"me"

/**
 * SID
 */

#define kGetMyMerchants @"getMyMerchants"
#define kStoreSetDefault @"setDefault"
#define kStoreCheckIn @"checkIn"

/**
 * GENERAL
 */
#define kGeneralApps @"General.Apps"
#define kGeneralMerchant @"General.Merchants"
#define kGeneralPublicMerchant @"General.PublicMerchants"
#define kGeneralSkeleton @"General.Skeletons"
#define kGeneralStore @"General.Stores"
#define kGeneralNews @"General.News"
#define kGeneralContact @"General.Contacts"
#define kGeneralTransaction @"General.Transactions"
#define kGeneralAccounts @"General.Accounts"
#define kGeneralAccountsGcm @"General.Accounts.Gcm"
#define kGeneralAccountsLocation @"General.Accounts.Location"
#define kGeneralAccountsBeacons @"General.Accounts.BeaconEnvironment"

/**
 * DOCUMENT
 */
#define kDocumentUpload @"Document.Uploads"

/**
 * LOYALTY
 */
#define kLoyaltyCard @"Loyalty.Cards"
#define kLoyaltyCardgroups @"Loyalty.CardGroups"
#define kLoyaltyMerchantcards @"Loyalty.MerchantCards"

typedef enum {
  
  OnDemandChannel,
  PersistentChannel,
  DefaultChannel
  
} ServiceChannel;

typedef enum {

  EventTypeChanged,
  EventTypeAdded,
  EventTypeDisplay,
  EventTypeBeaconMonitor,
//  EventTypePublicmerchantsAroundme,
//  EventTypeCheckinChanged,
//  EventTypeTransactionAdded
  
} SCEventType;

@interface SCGlobals : NSObject

+ (NSDateFormatter *)dateFormatter;
+ (NSError*) createErrorWithDescription:(NSString*)description;

@end
