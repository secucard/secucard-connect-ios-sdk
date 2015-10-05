//
//  SCErrorPayload.h
//  Pods
//
//  Created by Jörn Schmidt on 05.10.15.
//
//

#import <Mantle/Mantle.h>

@interface SCErrorPayload : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *error;
@property (nonatomic, copy) NSString *errorDetails;
@property (nonatomic, copy) NSString *errorUser;
@property (nonatomic, copy) NSNumber *code;
@property (nonatomic, copy) NSString *supportId;

@end
