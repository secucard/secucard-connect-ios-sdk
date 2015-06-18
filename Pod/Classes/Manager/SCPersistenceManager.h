//
//  SCPersistenceManager.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 13.11.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kErrorDomainSCPersistence                 @"SCSecucardCorePersistence"

@interface SCPersistenceManager : NSObject

+ (void) persist:(id)object forKey:(NSString*)key;
+ (id) itemForKey:(NSString*)key;
+ (void) removeItemForKey:(NSString*)key;
+ (BOOL) keyExists:(NSString*)key;

@end
