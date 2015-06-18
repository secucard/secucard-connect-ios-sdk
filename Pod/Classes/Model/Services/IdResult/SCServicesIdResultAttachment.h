//
//  SCServicesIdResultAttachment.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"
#import "SCMediaResource.h"

@interface SCServicesIdResultAttachment : SCMediaResource

@property (nonatomic, copy) NSString *type;

- (instancetype)initWithUrl:(NSString*)url andType:(NSString*)type;

@end
