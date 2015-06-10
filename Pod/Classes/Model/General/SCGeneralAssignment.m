//
//  SCGeneralAssignment.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCGeneralAssignment.h"

#import "SCGeneralMerchant.h"
#import "SCGeneralAccountDevice.h"
#import "SCLoyaltyCard.h"

@implementation SCGeneralAssignment

-(void)setAssign:(MTLModel *)assign {
  
  if ([assign isKindOfClass:[SCGeneralMerchant class]] ||
      [assign isKindOfClass:[SCGeneralAccountDevice class]] ||
      [assign isKindOfClass:[SCLoyaltyCard class]]) {
    
    _assign = assign;
    
  } else {
    NSLog(@"Cannot set object as asign, wrong type: %@", [[assign class] description]);
  }
  
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

@end
