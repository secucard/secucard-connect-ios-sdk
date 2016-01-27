//
//  SCError.h
//  Pods
//
//  Created by Jörn Schmidt on 27.01.16.
//
//

#import <Foundation/Foundation.h>

@interface SecuError : NSError

@property (nonatomic, retain) NSString *scStatus;
@property (nonatomic, retain) NSString *scError;
@property (nonatomic, retain) NSString *scErrorDetails;
@property (nonatomic, retain) NSString *scErrorUser;
@property (nonatomic, retain) NSNumber *scCode;
@property (nonatomic, retain) NSString *scSupportId;

+ (SecuError*) withError:(NSError*)error;
+ (SecuError*) withDictionary:(NSDictionary*)dict;
- (NSString*) errorString;

@end
