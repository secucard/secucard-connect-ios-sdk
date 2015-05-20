//
//  globals.h
//  SecucardConnectClientLib
//
//  Created by Jörn Schmidt on 18.05.15.
//  Copyright (c) 2015 Jörn Schmidt. All rights reserved.
//

#ifndef SecucardConnectClientLib_globals_h
#define SecucardConnectClientLib_globals_h

#define kBaseUrl                      @"https://connect.secucard.com/api/v2/"
#define kAuthUrl                      @"https://connect.secucard.com/"

#define kStompHost                    @"connect.secucard.com"
#define kStompVHost                   @"/"
#define kStompPort                    61614
#define kReplyQueue                   @"/temp-queue/secucard"
#define kConnectionTimeoutSec         30
#define kSocketTimeoutSec             30
#define kHeartbeatMs                  40000
#define kBasicDestination             @"connect.secucard.com"

#define kUsernameAppSample            @"checkout@secucard"
#define kPasswordAppSample            @"checkout"
#define kClientIdAppSample            @"app.mobile.secucard"
#define kClientSecretAppSample        @"576459f04ee8f67f7fcb1cf66416306e64517e01106090edfadbd381f81b58fc"
#define kDeviceIdAppSample            @"app_53c59b7445f149063f7b23c6"

#define kUsernameCashierSample        @"secucard.dresden"
#define kPasswordCashierSample        @"Kasse12345"
#define kClientIdCashierSample        @"app.mobile.secucard"
#define kClientSecretCashierSample    @"576459f04ee8f67f7fcb1cf66416306e64517e01106090edfadbd381f81b58fc"
#define kDeviceIdCashierSample        @"app_53c59b7445f149063f7b23c6"

#define kContactForename              @"DeviD"
#define kContactSurname               @"Testermann"
#define kContactSalutation            @"Herr"
#define kContactEmail                 @"schmidt@devid.net"

#define kAccountUsername               @"test_joern@devid.net"
#define kAcccountPassword              @"devid"


#endif
