//
//  SCAccountService.m
//  Pods
//
//  Created by Jörn Schmidt on 10.04.15.
//
//

#import "SCAccountService.h"

@implementation SCAccountService

-(void)updateAccount:(SCGeneralAccount *)account onComplete:(void (^)(SCGeneralAccount *, NSError *))completion {
  [SCErrorManager handleErrorWithDescription:@"not implemented"];
}

- (void)getAccount:(NSString *)id onComplete:(void (^)(SCGeneralAccount *, NSError *))completion {
  [SCErrorManager handleErrorWithDescription:@"not implemented"];
}

- (void)deleteAccount:(NSString *)id onComplete:(void (^)(BOOL, NSError *))completion {
  [SCErrorManager handleErrorWithDescription:@"not implemented"];
}

-(void)updateLocation:(NSString *)accountId location:(SCGeneralLocation *)location onComplete:(void (^)(BOOL, NSError *))completion {
  [SCErrorManager handleErrorWithDescription:@"not implemented"];
}

- (void)createAccount:(SCGeneralAccount *)account onComplete:(void (^)(SCGeneralAccount *, NSError *))completion {
  [SCErrorManager handleErrorWithDescription:@"not implemented"];
}

- (void)updateBeacons:(NSString *)accountId beachonList:(NSArray *)beaconList onComplete:(void (^)(BOOL, NSError *))completion {
  [SCErrorManager handleErrorWithDescription:@"not implemented"];
}

@end
