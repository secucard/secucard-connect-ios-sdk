//
//  SCClientConfiguration.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>
#import "SCRestServiceManager.h"
#import "SCStompManager.h"

@class SCRestConfiguration;
@class SCStompConfiguration;

typedef enum ServiceChannel {
  
  RestChannel,
  StompChannel
  
} ServiceChannel;

@interface SCClientCredentials : NSObject

@property (nonatomic, retain) NSString *clientId;
@property (nonatomic, retain) NSString *clientSecret;

@end

@interface SCUserCredentials : NSObject

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

@end

@interface SCClientConfiguration : NSObject

@property (nonatomic, retain) SCRestConfiguration *restConfiguration;
@property (nonatomic, retain) SCStompConfiguration *stompConfiguration;
@property (nonatomic, assign) ServiceChannel *defaultChannel;
@property (nonatomic, retain) NSNumber *heartBeatSec;
@property (nonatomic, assign) BOOL stompEnabled;
@property (nonatomic, retain) NSString *cacheDir;
// TODO: needed? @property (nonatomic, retain) NSNumber *authWaitTimeoutSec;
@property (nonatomic, retain) NSString *oauthUrl;
@property (nonatomic, retain) SCClientCredentials *clientCredentials;
@property (nonatomic, retain) SCUserCredentials *userCredentials;
@property (nonatomic, retain) NSString *deviceId;
@property (nonatomic, retain) NSString *authType;

@end
