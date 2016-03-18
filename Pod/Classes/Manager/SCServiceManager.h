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
#import "SCQueryParams.h"
#import "SCSecuObject.h"
#import "SCObjectList.h"
#import "SecuError.h"

@protocol SCServiceManagerProtocol <NSObject>

- (void) open:(void (^)(bool, SecuError*)) handler;
- (void) close;

- (void) getObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(id, SecuError *))handler;
- (void) getObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler;

- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams completionHandler:(void (^)(SCObjectList *list, SecuError *))handler;
- (void) findObjects:(Class)type queryParams:(SCQueryParams*)queryParams secure:(BOOL)secure completionHandler:(void (^)(SCObjectList *list, SecuError *))handler;

- (void) createObject:(SCSecuObject*)object completionHandler:(void (^)(id, SecuError *))handler;
- (void) createObject:(SCSecuObject*)object secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler;

- (void) updateObject:(SCSecuObject*)object completionHandler:(void (^)(SCSecuObject *responseObject, SecuError *))handler;
- (void) updateObject:(SCSecuObject*)object secure:(BOOL)secure completionHandler:(void (^)(SCSecuObject *responseObject, SecuError *))handler;

- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, SecuError *))handler;
- (void) updateObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler;

- (void) deleteObject:(Class)type objectId:(NSString*)objectId completionHandler:(void (^)(bool success, SecuError *))handler;
- (void) deleteObject:(Class)type objectId:(NSString*)objectId secure:(BOOL)secure completionHandler:(void (^)(bool success, SecuError *))handler;

- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg completionHandler:(void (^)(bool success, SecuError *))handler;
- (void) deleteObject:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg secure:(BOOL)secure completionHandler:(void (^)(bool success, SecuError *))handler;

- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg completionHandler:(void (^)(id, SecuError *))handler;
- (void) execute:(Class)type objectId:(NSString*)objectId action:(NSString*)action actionArg:(NSString*)actionArg arg:(id)arg secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler;

- (void) execute:(NSString*)appId action:(NSString*)action actionArg:(NSDictionary*)actionArg completionHandler:(void (^)(id, SecuError *))handler;
- (void) execute:(NSString*)appId action:(NSString*)action actionArg:(NSDictionary*)actionArg secure:(BOOL)secure completionHandler:(void (^)(id, SecuError *))handler;


@end

@interface SCServiceManager : NSObject <SCServiceManagerProtocol>

- (NSDictionary*) createDic:(id)object;

@end
