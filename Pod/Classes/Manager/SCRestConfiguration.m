//
//  SCRestServiceConfiguration.m
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import "SCRestConfiguration.h"

@interface SCRestConfiguration()

@property (nonatomic, retain) NSString *baseUrl;
@property (nonatomic, retain) NSString *authUrl;

@end

@implementation SCRestConfiguration

- (instancetype) initWithBaseUrl:(NSString*)baseUrl andAuthUrl:(NSString*)authUrl {
  self = [super init];
  if (self) {
    self.baseUrl = baseUrl;
    self.authUrl = authUrl;
  }
  return self;
  
}

@end
