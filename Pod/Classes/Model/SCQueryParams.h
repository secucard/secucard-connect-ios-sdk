//
//  QueryParams.h
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "SCGeoQuery.h"

#define kSortAsc              @"asc"
#define kSortDesc             @"desc"

#define kCountStandard        @10
#define kScrollExpireStandard @"5m"
#define kFieldsStandard       @"id"
#define kItemSort             @"asc"
#define kItemSortField        @"name"



@interface SCQueryParams : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *count;
@property (nonatomic, copy) NSNumber *offset;
@property (nonatomic, copy) NSString *scrollId;
@property (nonatomic, copy) NSString *scrollExpire;
@property (nonatomic, copy) NSMutableArray *fields;
@property (nonatomic, copy) NSMutableDictionary *sortOrder;
@property (nonatomic, copy) NSString *query;
@property (nonatomic, copy) NSString *preset;
@property (nonatomic, copy) SCGeoQuery *geoQuery;

- (void) addSortOrder:(NSString*)order forField:(NSString*)field;

@end
