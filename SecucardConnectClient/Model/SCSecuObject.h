//
//  SCSecuObject.h
//  Pods
//
//  Created by Jörn Schmidt on 13.04.15.
//
//

#import "MTLModel+Secucard.h"
#import <Mantle/Mantle.h>

#define kObjectProperty @"object"
#define kIdProperty @"id"

@interface SCSecuObject : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *id;

+ (NSString*) object;

+ (NSDateFormatter *)dateFormatter;

+ (NSDateFormatter *)dateShortFormatter;

@end
