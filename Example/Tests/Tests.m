//
//  SecucardConnectClientLibTests.m
//  SecucardConnectClientLibTests
//
//  Created by Jörn Schmidt on 04/25/2015.
//  Copyright (c) 2014 Jörn Schmidt. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <SecucardConnectClientLib/SCConnectClient.h>

SpecBegin(InitClient)

describe(@"InitClient", ^{
  
  it(@"can init", ^{
    
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
    
    SCUserCredentials *userCredentials = [[SCUserCredentials alloc] initWithUsername:kUsernameAppSample
                                                                         andPassword:kPasswordAppSample];
    
    expect(userCredentials).toNot.beNil();
    
    SCClientCredentials *clientCredentials = [[SCClientCredentials alloc] initWithClientId:kClientIdAppSample
                                                                              clientSecret:kClientSecretAppSample];
    
    expect(clientCredentials).toNot.beNil();
    
    SCClientConfiguration *clientConfig = [[SCClientConfiguration alloc] initWithRestConfiguration:restConfig
                                                                                stompConfiguration:stompConfig
                                                                                    defaultChannel:OnDemandChannel
                                                                                      stompEnabled:TRUE
                                                                                          oauthUrl:kAuthUrl
                                                                                 clientCredentials:clientCredentials
                                                                                   userCredentials:userCredentials
                                                                                          deviceId:kDeviceIdAppSample
                                                                                          authType:@"device"];
    
    expect(clientConfig).toNot.beNil();
    
    SCConnectClient *client = [[SCConnectClient sharedInstance] initWithConfiguration:clientConfig];
    
    expect(client).toNot.beNil();
    
  });
  
});

SpecEnd
