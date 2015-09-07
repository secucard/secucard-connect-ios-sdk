//
//  SCStompStorageItem.h
//  Pods
//
//  Created by Jörn Schmidt on 16.06.15.
//
//

#import <Foundation/Foundation.h>
#import "SCStompManager.h"

@interface SCStompStorageItem : NSObject

@property (nonatomic, copy) ReceiptHandler handler;

- (instancetype) initWithHandler:(ReceiptHandler)handler;

@end
