//
//  SCPersistenceManager.m
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 13.11.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import "SCPersistenceManager.h"

@implementation SCPersistenceManager

NSUserDefaults *defaults;

/**
 *  persist an object in user defaults
 *
 *  @param object the object to save
 *  @param key    the key as reference
 */
+ (void) persist:(id)object forKey:(NSString*)key
{
  if (defaults == nil) {
    defaults = [NSUserDefaults standardUserDefaults];
  }
  
  [defaults setObject:object forKey:key];
  [defaults synchronize];
  
}

/**
 *  retrive a persisted object
 *
 *  @param key the reference key
 *
 *  @return the saved value
 */
+ (id) itemForKey:(NSString*)key
{
  if (defaults == nil) {
    defaults = [NSUserDefaults standardUserDefaults];
  }
  
  if ([self keyExists:key]) {
    
    @try {
      return [defaults objectForKey:key];
    }
    @catch (NSException *exception) {
      return nil;
    }

  }
  
  return nil;
  
}

/**
 *  checks if a persisted object exists
 *
 *  @param key the reference key
 *
 */

+ (BOOL) keyExists:(NSString*)key
{
  
  if (defaults == nil) {
    defaults = [NSUserDefaults standardUserDefaults];
  }
  
  return ([defaults objectForKey:key] != nil);
}



/**
 *  removes a persisted object
 *
 *  @param key the reference key
 *
 */
+ (void) removeItemForKey:(NSString*)key
{
  
  if (defaults == nil) {
    defaults = [NSUserDefaults standardUserDefaults];
  }
  
  [defaults removeObjectForKey:key];
}

@end
