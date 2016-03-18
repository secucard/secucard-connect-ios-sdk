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
