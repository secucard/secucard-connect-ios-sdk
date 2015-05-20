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

SpecBegin(ConnectClient)

describe(@"ConnectClient", ^{

  __block SCConnectClient *client = nil;

  beforeAll(^{

    [[SCConnectClient sharedInstance] destroy];
    
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
                                                                                    defaultChannel:RestChannel
                                                                                      stompEnabled:TRUE
                                                                                          oauthUrl:kAuthUrl
                                                                                 clientCredentials:clientCredentials
                                                                                   userCredentials:userCredentials
                                                                                          deviceId:kDeviceIdAppSample
                                                                                          authType:@"device"];
    
    expect(clientConfig).toNot.beNil();
    
    client = [[SCConnectClient sharedInstance] initWithConfiguration:clientConfig];
    
    expect(client).toNot.beNil();

  });
  
  it (@"can register", ^{
    
    waitUntil(^(DoneCallback done) {
      
      SCGeneralContact *contact = [SCGeneralContact new];
      contact.forename = kContactForename;
      contact.surname = kContactSurname;
      contact.salutation = kContactSalutation;
      contact.dateOfBirth = [NSDate date];
      contact.email = kContactEmail;
      
      
      SCGeneralAccount *account = [SCGeneralAccount new];
      account.username = kAccountUsername;
      account.password = kAcccountPassword;
      account.contact = contact;
      
      [[SCAccountService sharedService] createAccount:account].then(^(SCGeneralAccount *savedAccount) {
        
        expect(savedAccount).toNot.beNil();
        
        if ([savedAccount isKindOfClass:[SCGeneralAccount class]]) {
          client.configuration.userCredentials = [[SCUserCredentials alloc] initWithUsername:savedAccount.username andPassword:savedAccount.password];
        } else {
          client.configuration.userCredentials = [[SCUserCredentials alloc] initWithUsername:account.username andPassword:account.password];
        }
        
        assert(TRUE);
        
      }).catch(^(NSError *error) {
        
        expect(error).to.beNil();
        
      }).finally(^() {
        
        done();
        
      });
      
      
    });
    
  });
  
  it(@"can connect", ^{

    waitUntil(^(DoneCallback done) {
      
      SCUserCredentials *userCredentials;
      if (client.configuration.userCredentials) {
        userCredentials = client.configuration.userCredentials;
      } else {
        userCredentials = [[SCUserCredentials alloc] initWithUsername:kAccountUsername andPassword:kAcccountPassword];
      }
      
      [[SCAccountManager sharedManager] loginWithUserCedentials:userCredentials].then(^(){
        
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
