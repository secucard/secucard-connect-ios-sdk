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

SharedExamplesBegin(MySharedExamples)
// Global shared examples are shared across all spec files.

sharedExamplesFor(@"foo", ^(NSDictionary *data) {
  
  __block id bar = nil;
  beforeEach(^{
    bar = data[@"bar"];
  });
  it(@"should not be nil", ^{
    XCTAssertNotNil(bar);
  });
  
});

SharedExamplesEnd

SpecBegin(ConnectClient)

describe(@"ConnectClient", ^{

  __block SCConnectClient *client = nil;

  beforeAll(^{

    SCRestConfiguration *restConfig = [[SCRestConfiguration alloc] initWithBaseUrl:@"https://connect.secucard.com/api/v2"
                                                                        andAuthUrl:@"https://connect.secucard.com/"];

    expect(restConfig).toNot.beNil();

    SCStompConfiguration *stompConfig = [[SCStompConfiguration alloc] initWithHost:@"connect.secucard.com"
                                                                          andVHost:@"/"
                                                                              port:61614
                                                                            userId:nil
                                                                          password:nil
                                                                            useSSL:TRUE
                                                                        replyQueue:@"/temp-queue/secucard"
                                                              connectionTimeoutSec:30
                                                                  socketTimeoutSec:30
                                                                       heartbeatMs:40000];

    expect(stompConfig).toNot.beNil();

    SCUserCredentials *userCredentials = [[SCUserCredentials alloc] initWithUsername:@"checkout@secucard.com"
                                                                         andPassword:@"checkout"];

    expect(userCredentials).toNot.beNil();

    SCClientCredentials *clientCredentials = [[SCClientCredentials alloc] initWithClientId:@"mobileapp_secucard"
                                                                              clientSecret:@"576459f04ee8f67f7fcb1cf66416306e64517e01106090edfadbd381f81b58fc"];

    expect(clientCredentials).toNot.beNil();

    SCClientConfiguration *clientConfig = [[SCClientConfiguration alloc] initWithRestConfiguration:restConfig
                                                                                stompConfiguration:stompConfig
                                                                                    defaultChannel:RestChannel
                                                                                      stompEnabled:TRUE
                                                                                          oauthUrl:@"https://connect.secucard.com/"
                                                                                 clientCredentials:clientCredentials
                                                                                   userCredentials:userCredentials
                                                                                          deviceId:@"app_53c59b7445f149063f7b23c6"
                                                                                          authType:@"device"];

    expect(clientConfig).toNot.beNil();

    client = [[SCConnectClient sharedInstance] initWithConfiguration:clientConfig];

    expect(client).toNot.beNil();

  });
  
  it(@"cannot connect anonymously", ^{
    
    waitUntil(^(DoneCallback done) {
      
      [client connect].then(^() {
        
        assert(FALSE);
        
      }).catch(^(NSError *error) {
        
        expect(error).toNot.beNil();
        
      }).finally(^() {
        
        done();
        
      });
      
    });
    
  });

  it(@"can connect", ^{

    waitUntil(^(DoneCallback done) {
      
      [[SCAccountManager sharedManager] loginWithUserCedentials:client.configuration.userCredentials].then(^(){
        
        return [client connect];
        
      }).then(^() {
        
        assert(TRUE);
        
      }).catch(^(NSError *error) {
        
        expect(error).to.beNil();
        
      }).finally(^() {
        
        done();
        
      });
      

    });

  });


});

SpecEnd
