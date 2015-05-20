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
#define kReplyQueue                   @"/temp-queue/main"
#define kConnectionTimeoutSec         30
#define kSocketTimeoutSec             30
#define kHeartbeatMs                  40000
#define kBasicDestination             @"/exchange/connect.api"

#define kUsernameAppSample            @"checkout@secucard"
#define kPasswordAppSample            @"checkout"
#define kClientIdAppSample            @"app.mobile.secucard"
#define kClientSecretAppSample        @"dc1f422dde755f0b1c4ac04e7efbd6c4c78870691fe783266d7d6c89439925eb"
#define kDeviceIdAppSample            @"611c00ec6b2be6c77c2338774f50040b"

#define kUsernameCashierSample        @"secucard.dresden"
#define kPasswordCashierSample        @"Kasse12345"
#define kClientIdCashierSample        @"611c00ec6b2be6c77c2338774f50040b"
#define kClientSecretCashierSample    @"dc1f422dde755f0b1c4ac04e7efbd6c4c78870691fe783266d7d6c89439925eb"
#define kDeviceIdCashierSample        @"/vendor/unknown/cashier/iostest1"
//#define kUUIDCashierSample            @"/vendor/unknown/cashier/iostest1"

#define kContactForename              @"DeviD"
#define kContactSurname               @"Testermann"
#define kContactSalutation            @"Herr"
#define kContactEmail                 @"schmidt@devid.net"

#define kAccountUsername               @"schmidt@devid.net"
#define kAcccountPassword              @"Secucard123"


#endif
