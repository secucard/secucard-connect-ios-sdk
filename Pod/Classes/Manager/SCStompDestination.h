//
//  SCStompDestination.h
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import <Foundation/Foundation.h>

@interface SCStompDestination : NSObject

@property (nonatomic, retain) NSString *command;

@property (nonatomic, retain) NSString *method;

@property (nonatomic, retain) Class type;

@property (nonatomic, retain, readonly) NSString *destination;

+ (instancetype) initWithCommand:(NSString*)command;
+ (instancetype) initWithCommand:(NSString*)command type:(Class)type;
+ (instancetype) initWithCommand:(NSString*)command type:(Class)type method:(NSString*)method;

@end

