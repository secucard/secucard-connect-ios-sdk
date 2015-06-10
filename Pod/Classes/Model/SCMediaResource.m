  //
//  SCMediaResource.m
//  Pods
//
//  Created by Jörn Schmidt on 11.04.15.
//
//

#import "SCMediaResource.h"

@implementation SCMediaResource

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

- (void) download {
  NSLog(@"Resource Download not implemented yet");
}

@end
