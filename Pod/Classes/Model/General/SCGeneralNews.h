//
//  SCGeneralNews.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCMediaResource.h"

#define kStatusRead @"read"
#define kStatusUnread @"unread"

@interface SCGeneralNews : SCSecuObject

@property (nonatomic, copy) NSString *headline;
@property (nonatomic, copy) NSString *textTeaser;
@property (nonatomic, copy) NSString *textFull;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *documentId;
@property (nonatomic, copy) NSDate *created;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *accountRead;
@property (nonatomic, copy) SCMediaResource *pictureObject;
@property (nonatomic, copy) NSArray *related;

@end
