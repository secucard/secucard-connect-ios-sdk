//
//  SCGeneralPublicMerchant.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralPublicMerchant.h"

@implementation SCGeneralPublicMerchant

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"addressComponents":@"address_components",
                                                                  @"addressFormatted":@"address_formatted",
                                                                  @"phoneNumberFormatted":@"phone_number_formatted",
                                                                  @"photoMain":@"photo_main",
                                                                  @"categoryMain":@"category_main",
                                                                  @"urlGooglePlus":@"url_googleplus",
                                                                  @"urlWebsite":@"url_website",
                                                                  @"utcOffset":@"utc_offset",
                                                                  @"openNow":@"open_now",
                                                                  @"openTime":@"open_time",
                                                                  @"openHours":@"open_hours",
                                                                  @"distance":@"_geometry",
                                                                  @"hashValue":@"hash"
                                                                  }];
}

+ (NSString *)object {
  return @"General.PublicMerchants";
}

@end
