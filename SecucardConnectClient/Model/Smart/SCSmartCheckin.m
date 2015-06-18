//
//  SCSmartCheckin.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCSmartCheckin.h"


@implementation SCSmartCheckin

+ (NSString *)object {
  return @"Smart.Checkins";
}

+ (NSValueTransformer *)accountJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralAccount class]];
}

+ (NSValueTransformer *)customerJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyCustomer class]];
}

+ (NSValueTransformer *)pictureObjectJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCMediaResource class]];
}

@end
