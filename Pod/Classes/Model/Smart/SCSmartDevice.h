//
//  SCSmartDevice.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSecuObject.h"

#import "SCGeneralMerchant.h"


@interface SCSmartDevice : SCSecuObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) SCGeneralMerchant *merchant;

@end
