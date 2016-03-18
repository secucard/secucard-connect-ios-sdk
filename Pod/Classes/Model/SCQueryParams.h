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
