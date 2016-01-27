//
//  SCError.m
//  Pods
//
//  Created by Jörn Schmidt on 27.01.16.
//
//

#import "SecuError.h"
#import <AFNetworking/AFNetworking.h>

@implementation SecuError

+ (SecuError*) withError:(NSError*)error {
  
  SecuError *err = [[SecuError alloc] initWithDomain:error.domain code:error.code userInfo:error.userInfo];
  
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
  
  return err;
}

+ (SecuError*) withDictionary:(NSDictionary*)dict {
  
  SecuError *err = [SecuError new];
  
    err.scStatus = [dict objectForKey:@"status"];
    err.scCode = [dict objectForKey:@"code"];
    err.scError = [dict objectForKey:@"error"];
    err.scErrorUser = [dict objectForKey:@"error_user"];
    err.scErrorDetails = [dict objectForKey:@"error_details"];
    err.scSupportId = [dict objectForKey:@"supportId"];
  
  return err;
}

- (NSString*) errorString {
  
  return [NSString stringWithFormat:@"Code: %@ | %@ | %@", self.scCode, self.scError, self.scErrorDetails];
  
}

@end
