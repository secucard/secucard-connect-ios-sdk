//
//  SCServicesIdResultContactData.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCServicesIdResultContactData : MTLModel

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *email;

@end
