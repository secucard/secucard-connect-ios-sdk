//
//  SCObjectList.h
//  Pods
//
//  Created by Jörn Schmidt on 13.04.15.
//
//

#import "SCBaseModel.h"

@interface SCObjectList : SCBaseModel

@property (nonatomic, copy) NSString *scrollId;
@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSArray *list;

@end
