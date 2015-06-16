//
//  SCAppDestination.h
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import <Foundation/Foundation.h>
#import "SCStompDestination.h"

@interface SCAppDestination : SCStompDestination

@property (nonatomic, retain) NSString *appId;

+ (instancetype) initWithAppId:(NSString *)appId method:(NSString*)method;

@end

