//
//  SCServiceCallWrapper.h
//  SecucardAppCore
//
//  Created by Jörn Schmidt on 13.11.14.
//  Copyright (c) 2014 secucard. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMe @"me"

typedef enum CallMethod
{
  MethodGet,
  MethodAdd,
  MethodUpdate,
  MethodRemove,
  MethodExecute
  
} CallMethod;

@interface SCServiceCallWrapper : NSObject

@property (nonatomic, assign) CallMethod method;
@property (nonatomic, retain) NSString *action;
@property (nonatomic, retain) NSString *pid;
@property (nonatomic, retain) NSString *sid;
@property (nonatomic, retain) id data;

@end
