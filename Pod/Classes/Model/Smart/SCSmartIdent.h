//
//  SCSmartIdent.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCLoyaltyMerchantCard.h"

@interface SCSmartIdent : SCSecuObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *length;
@property (nonatomic, copy) NSString *prefix;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) SCLoyaltyCustomer *customer;
@property (nonatomic, copy) SCLoyaltyMerchantCard *merchantCard;
@property (nonatomic, assign) BOOL valid;

@end
