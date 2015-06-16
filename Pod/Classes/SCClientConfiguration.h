//
//  SCClientConfiguration.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>

#import "SCGlobals.h"

#import "SCClientCredentials.h"
#import "SCUserCredentials.h"

#import "SCRestConfiguration.h"
#import "SCStompConfiguration.h"

@interface SCClientConfiguration : NSObject

@property (nonatomic, retain) SCRestConfiguration *restConfiguration;
@property (nonatomic, retain) SCStompConfiguration *stompConfiguration;
@property (nonatomic, assign) ServiceChannel defaultChannel;
@property (nonatomic, assign) BOOL stompEnabled;
@property (nonatomic, retain) NSString *oauthUrl;
@property (nonatomic, retain) SCClientCredentials *clientCredentials;
@property (nonatomic, retain) SCUserCredentials *userCredentials;
@property (nonatomic, retain) NSString *deviceId;
@property (nonatomic, retain) NSString *authType;

- (instancetype) initWithRestConfiguration:(SCRestConfiguration*)restConfig stompConfiguration:(SCStompConfiguration*)stompConfig defaultChannel:(ServiceChannel)defaultChannel stompEnabled:(BOOL)stompEnabled oauthUrl:(NSString*)oauthUrl clientCredentials:(SCClientCredentials*)clientCredentials userCredentials:(SCUserCredentials*)userCredentials deviceId:(NSString*)deviceId authType:(NSString*)authType;

@end
