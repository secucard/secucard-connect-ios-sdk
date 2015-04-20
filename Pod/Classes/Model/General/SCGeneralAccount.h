//
//  SCGeneralAccount.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCGeneralContact.h"

@interface SCGeneralAccount : SCSecuObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *role;
@property (nonatomic, copy) SCGeneralContact *contact;

@end
