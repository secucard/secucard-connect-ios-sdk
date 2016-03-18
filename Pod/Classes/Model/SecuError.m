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

#import "SecuError.h"
#import <AFNetworking/AFNetworking.h>

@implementation SecuError

+ (SecuError*) withError:(NSError*)error {
  
  if (!error) {
    return nil;
  }
  
  SecuError *err = [[SecuError alloc] initWithDomain:error.domain code:error.code userInfo:error.userInfo];
  
  if ([err.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey] != nil) {
    
    NSData *errorData = [err.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
    
    NSError *parsingError;
    id object = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingAllowFragments error:&parsingError];
    
    if (parsingError == nil) {
      
      err.scStatus = [object objectForKey:@"status"];
      err.scCode = [object objectForKey:@"code"];
      err.scError = [object objectForKey:@"error"];
      err.scErrorUser = [object objectForKey:@"error_user"];
      err.scErrorDetails = [object objectForKey:@"error_details"];
      err.scSupportId = [object objectForKey:@"supportId"];
      
    }
    
  }
  
  return err;
}

+ (SecuError*) withDictionary:(NSDictionary*)dict {
  
  NSString *domain = [dict objectForKey:@"error"];
  if (!domain) {
    domain = @"Unknown";
  }
  
  NSString *info = [dict objectForKey:@"error_user"];
  if (!info) {
    info = @"Something went wrong";
  }
  
  NSInteger code = [[dict objectForKey:@"code"] integerValue];
  if (!code) {
    code = 0;
  }
  
  SecuError *err = [[SecuError alloc] initWithDomain:domain code:code userInfo:@{NSLocalizedDescriptionKey: info}];

  err.scStatus = [dict objectForKey:@"status"];
  err.scCode = [dict objectForKey:@"code"];
  err.scError = [dict objectForKey:@"error"];
  err.scErrorUser = [dict objectForKey:@"error_user"];
  err.scErrorDetails = [dict objectForKey:@"error_details"];
  err.scSupportId = [dict objectForKey:@"supportId"];
  
  return err;
  
}

- (NSString*) errorString {
  
  if (self.scCode != nil && self.scError != nil && self.scErrorDetails != nil) {
    return [NSString stringWithFormat:@"Code: %@ | %@ | %@", self.scCode, self.scError, self.scErrorDetails];
  } else {
    return self.localizedDescription;
  }
  
  
}

@end