//
//  SCGeneralAccount.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralAccount.h"
#import <Mantle/MTLJSONAdapter.h>
@implementation SCGeneralAccount

+ (NSString *)object {
  return @"General.Accounts";
}

+ (NSValueTransformer *)contactJSONTransformer {
  return [MTLJSONAdapter dictionaryTransformerWithModelClass:SCGeneralContact.class];
}

@end
