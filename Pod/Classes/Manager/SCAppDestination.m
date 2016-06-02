/******************************************
 *
 *  Copyright (c) 2015. hp.weber GmbH & Co secucard KG (www.secucard.com)
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 ******************************************/

#import "SCAppDestination.h"
#import "SCStompManager.h"

@implementation SCAppDestination

+ (instancetype) initWithCommand:(NSString*)command type:(Class)type method:(NSString*)method {
  
  SCAppDestination *destination = [SCAppDestination new];
  
  destination.command = command;
  destination.type = type;
  destination.method = method;
  
  return destination;
  
}

+ (instancetype) initWithAppId:(NSString *)appId method:(NSString*)method {
  
  SCAppDestination *appDest = [SCAppDestination initWithCommand:nil type:nil method:method];
  appDest.appId = appId;
  return appDest;
  
}

- (NSString *)destination {
  return [NSString stringWithFormat:@"%@%@%@", [SCStompManager sharedManager].configuration.basicDestination, kAppDestinationPrefix, self.method];
}

@end