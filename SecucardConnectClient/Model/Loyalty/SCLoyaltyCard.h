//
//  SCLoyaltyCard.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"
#import "SCGeneralAccount.h"

@interface SCLoyaltyCard : SCSecuObject

@property (nonatomic, copy) NSString *cardNumber;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) SCGeneralAccount *account;

@end
