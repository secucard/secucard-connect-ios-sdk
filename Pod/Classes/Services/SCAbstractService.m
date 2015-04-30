//
//  SCAbstractService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAbstractService.h"
#import "SCErrorManager.h"
#import "SCRestServiceManager.h"
#import "SCStompManager.h"
#import "SCObjectList.h"

@implementation SCAbstractService

/**
 *  retrieve the channel from the given channel type.
 *
 *  @param channel teh channel type
 *
 *  @return a sublass of the ServiceManager, either Stomp or Rest
 */
- (SCServiceManager*) serviceManagerByChannel:(ServiceChannel)channel {
  
  switch (channel) {
    case RestChannel:
      return [SCRestServiceManager sharedManager];
    
    case StompChannel:
      return [SCStompManager sharedManager];
      
    default:
      
    {
      switch ([SCConnectClient sharedInstance].configuration.defaultChannel) {
        case RestChannel:
          return [SCRestServiceManager sharedManager];
          
        case StompChannel:
          return [SCStompManager sharedManager];
          
        default:
          [SCErrorManager handleError:[SCErrorManager errorWithDescription:@"No channel given and not default channel set in client configuration"]];
          return nil;
          
      }
    }
      
  }
  
}

/**
 *  retrieve an object
 *
 *  @param type    the class type
 *  @param id      the id
 *  @param channel the preferred channel
 *
 *  @return a promise fulfilling with the found instance (id)
 */
- (PMKPromise*) get:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel {
  
  return [[self serviceManagerByChannel:channel] getObject:type objectId:id];
  
}

/**
 *  retrieve a list of objects which is a NSArray
 *
 *  @param type        the class type of the resulting objects
 *  @param queryParams the query parameters
 *  @param channel     the preferred channel
 *
 *  @return a promise fulfilling with a NSArray of the found objects (NSArray)
 */
- (PMKPromise*) getList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    [[self serviceManagerByChannel:channel] findObjects:type queryParams:queryParams].then(^(SCObjectList* objectList) {
      
      // convert object list to list
      
      // if nil result and no error, return empty array
      if (!objectList || objectList.count == 0) {
        reject([SCErrorManager errorWithCode:ERR_INVALID_RESULT]);
      }
      
      return [self postProcessObjects:objectList.list];
      
    }).then(^(NSArray *list) {
      
      // fulfill promise with *objectList.list*
      fulfill(list);
      
    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
    
  }];
  
}

/**
 *  retrieve a list of objects which is a SCObjectList
 *
 *  @param type        the class type of the resulting objects
 *  @param queryParams the query parameters
 *  @param channel     the preferred channel
 *
 *  @return a promise fulfilling with a SCObjectList of the found objects (SCObjectList)
 */
- (PMKPromise*) getObjectList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    
    __block SCObjectList *objList;
    
    [[self serviceManagerByChannel:channel] findObjects:type queryParams:queryParams].then(^(SCObjectList* objectList) {
      
      // convert object list to list
      
      // if nil result and no error, return empty array
      if (!objectList || objectList.count == 0) {
        reject([SCErrorManager errorWithCode:ERR_INVALID_RESULT]);
      }
      
      // save object list for later return
      objList = objectList;
      
      // process list
      return [self postProcessObjects:objectList.list];
      
    }).then(^(NSArray *list) {
      
      // fulfill promise with real *objectList*
      fulfill(objList);
      
    }).catch(^(NSError *error) {
      
      reject(error);
      
    });
    
  }];
  
}

/**
 *  Post process the objects found by the list retireval methods, this is used internally after a list result arrived and before it is passed by the promise fulfiller
 *
 *  @param list the input list
 *
 *  @return a promise fulfilling with the output list (NSArray)
 */
- (PMKPromise*) postProcessObjects:(NSArray*)list {
  
  return [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
    fulfill(list);
  }];
  
}

//  TODO: check return value
/**
 *  saves an object server-side
 *
 *  @param object  the object to be saved
 *  @param channel the preferred channel
 *
 *  @return a promise fulfilling with the refreshed object (SCSecuObject)
 */
- (PMKPromise*) update:(id)object onChannel:(ServiceChannel)channel {
  
  return [[self serviceManagerByChannel:channel] updateObject:object];
  
}

// TODO: need returnType?
/**
 *  execute an object server-side
 *
 *  @param type       the class type
 *  @param id         the object's id
 *  @param action     a string clarifying the action to take
 *  @param actionArg  the parameters for the action as string
 *  @param arg        a dictionary as argument
 *  @param returnType the wanted return type
 *  @param channel    the preferred channel
 *
 *  @return a promise fulfilling with the result (id)
 */
- (PMKPromise*) execute:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel {
  
  return [[self serviceManagerByChannel:channel] execute:type objectId:id action:action actionArg:actionArg arg:arg];
  
}

// TODO: need returnType?
/**
 *  execute an object server-side
 *
 *  @param appId      the app id
 *  @param action     a string clarifying the action to take
 *  @param arg        a dictionary as argument
 *  @param returnType the wanted return type
 *  @param channel    the preferred channel
 *
 *  @return a promise fulfilling with the result (id)
 */
- (PMKPromise*) execute:(NSString*)appId action:(NSString*)action arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel {
  
  return [[self serviceManagerByChannel:channel] execute:appId action:action actionArg:arg];
  
}

/**
 *  create an object server-side
 *
 *  @param object  the object
 *  @param channel the preferred channel
 *
 *  @return a promise returning the created object (id)
 */
- (PMKPromise*) create:(id)object onChannel:(ServiceChannel)channel {
  
  return [[self serviceManagerByChannel:channel] createObject:object];
  
}

/**
 *  deletes an object server-side
 *
 *  @param type    the class type
 *  @param id      the id of the object
 *  @param channel the preferred channel
 *
 *  @return a promise just fulfilling without result (nil)
 */
- (PMKPromise*) delete:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel {
  
  return [[self serviceManagerByChannel:channel] deleteObject:type objectId:id];
  
}

/**
 *  deletes an object server-side telling the server to take action
 *
 *  @param type      the class type
 *  @param id        the object's id
 *  @param action    the action to take
 *  @param actionArg the action arguments as string
 *  @param channel   the preferred channel
 *
 *  @return a promise just fulfilling without result (nil)
 */
- (PMKPromise*) delete:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg onChannel:(ServiceChannel)channel {
  
  return [[self serviceManagerByChannel:channel] deleteObject:type objectId:id action:action actionArg:actionArg];
  
}

@end
