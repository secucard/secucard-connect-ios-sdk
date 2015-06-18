//
//  SCGeneralAddress.h
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "MTLModel+Secucard.h"

@interface SCGeneralAddress : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *streetNumber;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *country;
//@property (nonatomic, copy) NSLocale *countryLocale = null;

@end
