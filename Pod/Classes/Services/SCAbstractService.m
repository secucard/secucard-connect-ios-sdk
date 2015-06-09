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
    case OnDemandChannel:
      return [SCRestServiceManager sharedManager];
    
    case PersistentChannel:
      return [SCStompManager sharedManager];
      
    default:
      
    {
      switch ([SCConnectClient sharedInstance].configuration.defaultChannel) {
        case OnDemandChannel:
          return [SCRestServiceManager sharedManager];
          
        case PersistentChannel:
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
 *  @return a promise resolveing with the found instance (id)
 */
- (void) get:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, NSError *))handler {
  
  [[self serviceManagerByChannel:channel] getObject:type objectId:id completionHandler:handler];
  
}

/**
 *  retrieve a list of objects which is a NSArray
 *
 *  @param type        the class type of the resulting objects
 *  @param queryParams the query parameters
 *  @param channel     the preferred channel
 *
 *  @return a promise resolveing with a NSArray of the found objects (NSArray)
 */
- (void) getList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel completionHandler:(void (^)(NSArray *, NSError *))handler {
  
     [[self serviceManagerByChannel:channel] findObjects:type queryParams:queryParams completionHandler:^(SCObjectList *list, NSError *error) {
      
      // if nil result and no error, return empty array
      if (!list || [list.count isEqual:@0]) {
        handler(@[], nil);
        return;
      }
      
       // map objects in list
       if (list.data) {
         list.data = [self typeArray:list.data withType:type];
       }
       
      // process list
      [self postProcessObjects:list.data completionHandler:^(NSArray *processedList, NSError *error) {
        handler(processedList, error);
      }];
      
    }];
  
}

/**
 *  retrieve a list of objects which is a SCObjectList
 *
 *  @param type        the class type of the resulting objects
 *  @param queryParams the query parameters
 *  @param channel     the preferred channel
 *
 *  @return a promise resolveing with a SCObjectList of the found objects (SCObjectList)
 */
- (void) getObjectList:(Class)type withParams:(SCQueryParams*)queryParams onChannel:(ServiceChannel)channel completionHandler:(void (^)(SCObjectList *, NSError *))handler {
  
    __block SCObjectList *objList;
    
    [[self serviceManagerByChannel:channel] findObjects:type queryParams:queryParams completionHandler:^(SCObjectList *list, NSError *error) {
      
      // if nil result and no error, return an object with empty array
      if (!list || [list.count isEqual:@0]) {
        SCObjectList *emptyListObject = [SCObjectList new];
        emptyListObject.data = @[];
        handler(emptyListObject, nil);
        return;
      }
      
      // save object list for later return
      objList = list;
      
      // map objects in list
      if (list.data) {
          list.data = [self typeArray:list.data withType:type];
      }
      
      // process list
      [self postProcessObjects:list.data completionHandler:^(NSArray *processedList, NSError *error) {
      
        if (error != nil) {
          objList.data = processedList;
        }
        
        handler(objList, error);
      }];
      
      
    }];
  
}

- (NSArray*) typeArray:(NSArray*)array withType:(Class)class {
  
  NSMutableArray *typedArray = [NSMutableArray new];
  for (id object in array) {
    NSError *parsingError = nil;
    id typedObject = [MTLJSONAdapter modelOfClass:class fromJSONDictionary:object error:&parsingError];
    [typedArray addObject:typedObject];
  }
  return [NSArray arrayWithArray:typedArray];
}


/**
 *  Post process the objects found by the list retireval methods, this is used internally after a list result arrived and before it is passed by the promise resolveer
 *
 *  @param list the input list
 *
 *  @return a promise resolveing with the output list (NSArray)
 */
- (void) postProcessObjects:(NSArray*)list completionHandler:(void (^)(NSArray *, NSError *))handler {
  
  handler(list, nil);
  
}

//  TODO: check return value
/**
 *  saves an object server-side
 *
 *  @param object  the object to be saved
 *  @param channel the preferred channel
 *
 *  @return a promise resolveing with the refreshed object (SCSecuObject)
 */
- (void) update:(id)object onChannel:(ServiceChannel)channel completionHandler:(void (^)(SCSecuObject *, NSError *))handler {
  
  [[self serviceManagerByChannel:channel] updateObject:object completionHandler:handler];
  
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
 *  @return a promise resolveing with the result (id)
 */
- (void) execute:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, NSError *))handler {
  
  [[self serviceManagerByChannel:channel] execute:type objectId:id action:action actionArg:actionArg arg:arg completionHandler:handler];
  
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
 *  @return a promise resolveing with the result (id)
 */
- (void) execute:(NSString*)appId action:(NSString*)action arg:(id)arg returnType:(Class)returnType onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, NSError *))handler {
  
  [[self serviceManagerByChannel:channel] execute:appId action:action actionArg:arg completionHandler:handler];
  
}

/**
 *  create an object server-side
 *
 *  @param object  the object
 *  @param channel the preferred channel
 *
 *  @return a promise returning the created object (id)
 */
- (void) create:(id)object onChannel:(ServiceChannel)channel completionHandler:(void (^)(id, NSError *))handler {
  
  [[self serviceManagerByChannel:channel] createObject:object completionHandler:handler];
  
}

/**
 *  deletes an object server-side
 *
 *  @param type    the class type
 *  @param id      the id of the object
 *  @param channel the preferred channel
 *
 *  @return a promise just resolveing without result (nil)
 */
- (void) delete:(Class)type withId:(NSString*)id onChannel:(ServiceChannel)channel completionHandler:(void (^)(bool, NSError *))handler {
  
  [[self serviceManagerByChannel:channel] deleteObject:type objectId:id completionHandler:handler];
  
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
 *  @return a promise just resolveing without result (nil)
 */
- (void) delete:(Class)type withId:(NSString*)id action:(NSString*)action actionArg:(NSString*)actionArg onChannel:(ServiceChannel)channel completionHandler:(void (^)(bool, NSError *))handler {
  
  [[self serviceManagerByChannel:channel] deleteObject:type objectId:id action:action actionArg:actionArg completionHandler:handler];
  
}

@end
