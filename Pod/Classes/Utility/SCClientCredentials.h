//
//  SCClientCredentials.h
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import <Foundation/Foundation.h>

@interface SCClientCredentials : NSObject

@property (nonatomic, retain) NSString *clientId;
@property (nonatomic, retain) NSString *clientSecret;

- (instancetype) initWithClientId:(NSString*)clientId clientSecret:(NSString*)clientSecret;

@end
