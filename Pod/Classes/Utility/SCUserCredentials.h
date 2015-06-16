//
//  SCUserCredentials.h
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import <Foundation/Foundation.h>

@interface SCUserCredentials : NSObject

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

- (instancetype) initWithUsername:(NSString*)username andPassword:(NSString*)password;

@end
