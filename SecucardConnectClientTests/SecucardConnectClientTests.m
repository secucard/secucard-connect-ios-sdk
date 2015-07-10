//
//  SecucardConnectClientTests.m
//  SecucardConnectClientTests
//
//  Created by Jörn Schmidt on 18.06.15.
//  Copyright (c) 2015 secucard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SCConnectClient.h"
//#import "SCQueryParams.h"
//#import "SCGeoQuery.h"
//#import "SCSecuAppService.h"

@interface SecucardConnectClientTests : XCTestCase

@end

@implementation SecucardConnectClientTests

- (void)setUp {

  [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
  
//  SCQueryParams *params = [SCQueryParams new];
//  params.count = @10;
//  params.fields = [NSMutableArray arrayWithArray:@[@"id",@"name",@"photo_main",@"category_main",@"open_now",@"_geometry",@"photo",@"geometry",@"address_formatted",@"_balance",@"_points",@"_news_status",@"_checkin_status"]];
//  params.scrollExpire = @"5m";
//  params.sortOrder = [NSMutableDictionary dictionaryWithDictionary:@{@"_geometry":kSortAsc}];
//  params.preset = kPresetOwn;
//  params.geoQuery = [SCGeoQuery new];
//  params.geoQuery.field = @"geometry";
//  params.geoQuery.lat = 51.0;
//  params.geoQuery.lon = 13.0;
//  params.geoQuery.distance = @"1000km";
//
//  
//  [[SCSecuAppService sharedService] getMerchants:@"APP_3FRGENHHK2Y3VWW47J8KYC4M8SBMA4" arg:params completionHandler:^(SCStoreList *storeList, NSError *error) {
//  
//    NSLog(@"%@", storeList);
//    
//  }];
  
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
