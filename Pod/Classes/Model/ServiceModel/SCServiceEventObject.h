//
//  SCServiceEventObject.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 13.11.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCServiceEventObject : NSObject

+ (id) initWithDictionary:(NSDictionary*)dictionary;

@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *id;
@property (nonatomic, retain) id data;

@end
