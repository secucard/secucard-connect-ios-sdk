//
//  SCGeneralStore.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralStore.h"


@implementation SCGeneralStore

+ (NSString *)object {
  return @"General.Stores";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  NSDictionary *standards = [super JSONKeyPathsByPropertyKey];
  
  return [standards mtl_dictionaryByAddingEntriesFromDictionary:@{
                                                                  @"hashProperty":@"hash",
                                                                  @"nameRaw":@"name_raw",
                                                                  @"newsStatus":@"_news_status",
                                                                  @"news":@"_news",
                                                                  @"openNow":@"open_now",
                                                                  @"openTime":@"open_time",
                                                                  @"openHours":@"open_hours",
                                                                  @"distance":@"_geometry",
                                                                  @"checkInStatus":@"_checkin_status",
                                                                  @"addressFormatted":@"address_formatted",
                                                                  @"addressComponents":@"address_components",
                                                                  @"categoryMain":@"category_main",
                                                                  @"phoneNumberFormatted":@"phone_number_formatted",
                                                                  @"urlWebsite":@"url_website",
                                                                  @"balance":@"_balance",
                                                                  @"points":@"_points",
                                                                  @"program":@"_program",
                                                                  @"isDefault":@"_isDefault",
                                                                  @"facebookId":@"facebook_id",
                                                                  @"pictureUrls":@"photo",
                                                                  @"logoUrl":@"photo_main",
                                                                  @"hasBeacon":@"has_beacon"
                                                                  }];
}

+ (NSValueTransformer *)merchantJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralMerchant class]];
}

+ (NSValueTransformer *)geometryJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCGeneralComponentsGeometry class]];
}

+ (NSValueTransformer *)programJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCLoyaltyProgram class]];
}

+ (NSValueTransformer *)logoJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:[SCMediaResource class]];
}

+ (NSValueTransformer *)newsJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[SCGeneralNews class]];
}

+ (NSValueTransformer *)openHoursJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[SCGeneralComponentsOpenHours class]];
}

+ (NSValueTransformer *)addressComponentsJSONTransformer {
  return [MTLJSONAdapter arrayTransformerWithModelClass:[SCGeneralComponentsAddressComponent class]];
}

@end
