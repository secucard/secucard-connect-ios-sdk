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
#import "SCGlobals.h"

@interface SCClientCredentials : NSObject

@property (nonatomic, retain) NSString *clientId;
@property (nonatomic, retain) NSString *clientSecret;

- (instancetype) initWithClientId:(NSString*)clientId clientSecret:(NSString*)clientSecret;

@end

@interface SCUserCredentials : NSObject

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

- (instancetype) initWithUsername:(NSString*)username andPassword:(NSString*)password;

@end

@class SCRestConfiguration;
@class SCStompConfiguration;

@interface SCClientConfiguration : NSObject

@property (nonatomic, retain) SCRestConfiguration *restConfiguration;
@property (nonatomic, retain) SCStompConfiguration *stompConfiguration;
@property (nonatomic, assign) ServiceChannel defaultChannel;
@property (nonatomic, assign) BOOL stompEnabled;
// TODO: needed? @property (nonatomic, retain) NSString *cacheDir;
// TODO: needed? @property (nonatomic, retain) NSNumber *authWaitTimeoutSec;
@property (nonatomic, retain) NSString *oauthUrl;
@property (nonatomic, retain) SCClientCredentials *clientCredentials;
@property (nonatomic, retain) SCUserCredentials *userCredentials;
@property (nonatomic, retain) NSString *deviceId;
@property (nonatomic, retain) NSString *authType;

- (instancetype) initWithRestConfiguration:(SCRestConfiguration*)restConfig stompConfiguration:(SCStompConfiguration*)stompConfig defaultChannel:(ServiceChannel)defaultChannel stompEnabled:(BOOL)stompEnabled oauthUrl:(NSString*)oauthUrl clientCredentials:(SCClientCredentials*)clientCredentials userCredentials:(SCUserCredentials*)userCredentials deviceId:(NSString*)deviceId authType:(NSString*)authType;

@end
