//
//  TestStuff.m
//  SecucardConnectClientLib
//
//  Created by Jörn Schmidt on 28.04.15.
//  Copyright (c) 2015 Jörn Schmidt. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Expecta/Expecta.h>
#import <SecucardConnectClientLib/SCConnectClient.h>

SpecBegin(ConnectDeviceClient)

describe(@"ConnectDeviceClient", ^{

  __block SCConnectClient *client = nil;

  beforeAll(^{
    
    [[SCConnectClient sharedInstance] destroy:^(bool success, NSError *error) {
      
      expect(success).to.beTruthy();
      expect(error).to.beNil();
      
    }];

    SCRestConfiguration *restConfig = [[SCRestConfiguration alloc] initWithBaseUrl:kBaseUrl
                                                                        andAuthUrl:kAuthUrl];
    
    expect(restConfig).toNot.beNil();
    
    SCStompConfiguration *stompConfig = [[SCStompConfiguration alloc] initWithHost:kStompHost
                                                                          andVHost:kStompVHost
                                                                              port:kStompPort
                                                                            userId:nil
                                                                          password:nil
                                                                            useSSL:TRUE
                                                                        replyQueue:kReplyQueue
                                                              connectionTimeoutSec:kConnectionTimeoutSec
                                                                  socketTimeoutSec:kSocketTimeoutSec
                                                                       heartbeatMs:kHeartbeatMs
                                                                  basicDestination:kBasicDestination];
    
    expect(stompConfig).toNot.beNil();
    
//    SCUserCredentials *userCredentials = [[SCUserCredentials alloc] initWithUsername:kUsernameCashierSample
//                                                                         andPassword:kPasswordCashierSample];
//    
//    expect(userCredentials).toNot.beNil();
    
    SCClientCredentials *clientCredentials = [[SCClientCredentials alloc] initWithClientId:kClientIdCashierSample
                                                                              clientSecret:kClientSecretCashierSample];
    
    expect(clientCredentials).toNot.beNil();
    
    SCClientConfiguration *clientConfig = [[SCClientConfiguration alloc] initWithRestConfiguration:restConfig
                                                                                stompConfiguration:stompConfig
                                                                                    defaultChannel:OnDemandChannel
                                                                                      stompEnabled:TRUE
                                                                                          oauthUrl:kAuthUrl
                                                                                 clientCredentials:clientCredentials
                                                                                   userCredentials:nil
                                                                                          deviceId:kDeviceIdCashierSample
                                                                                          authType:@"device"];
    
    expect(clientConfig).toNot.beNil();
    
    client = [SCConnectClient sharedInstance];
    
    expect(client).toNot.beNil();
    
    [client initWithConfiguration:clientConfig];
    
  });
  
  it(@"can connect anonymously", ^{
    
    NSLog(@"AccessToken %@", [SCAccountManager sharedManager].accessToken);
    NSLog(@"RefreshToken %@", [SCAccountManager sharedManager].refreshToken);
    
    //[[SCAccountManager sharedManager] killToken];
    
    if ([SCAccountManager sharedManager].accessToken == nil) {
      setAsyncSpecTimeout(1200);
    } else {
      setAsyncSpecTimeout(10);
    }
    
    waitUntil(^(DoneCallback done) {
      
      [client connect:^(bool success, NSError *error) {
        
        expect(success).to.beTruthy();
        expect(error).to.beNil();
        
        [[SCStompManager sharedManager] execute:[SCConnectClient sharedInstance].configuration.deviceId action:@"me" actionArg:@"auth.refresh" completionHandler:^(id response, NSError *error) {
          
          expect(error).to.beNil();
          assert(TRUE);
          
          done();
          
        }];
        
      }];
      
    });
    
  });

});

SpecEnd
