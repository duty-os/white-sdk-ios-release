//
//  WhiteObjectTests.m
//  WhiteSDKPrivate_Tests
//
//  Created by yleaf on 2019/6/7.
//  Copyright © 2019 leavesster. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <WhiteSDK.h>

@interface WhiteObjectTests : XCTestCase

@end

@implementation WhiteObjectTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testPlayConfigSecConvert
{
    WhitePlayerConfig *pConfig = [[WhitePlayerConfig alloc] initWithRoom:@"room" roomToken:@"roomToken"];
    pConfig.duration = @40;
    NSNumber *beginTimestamp = @([[NSDate dateWithTimeIntervalSince1970:2000] timeIntervalSince1970]);
    pConfig.beginTimestamp = beginTimestamp;
    
    NSDictionary *dict = [pConfig jsonDict];
    NSLog(@"dict:%@", dict);
    
    // 在 iOS 端传给 js 端时，自动切换为毫秒精度
    XCTAssertEqual([dict[@"duration"] integerValue], 40 * 1000);
    XCTAssertEqual([dict[@"beginTimestamp"] integerValue], [beginTimestamp integerValue] * 1000);
}

- (void)testPlayConfigNoSecConvert
{
    WhitePlayerConfig *pConfig = [[WhitePlayerConfig alloc] initWithRoom:@"room" roomToken:@"roomToken"];
    
    NSDictionary *dict = [pConfig jsonDict];
    NSLog(@"dict:%@", dict);
    
    XCTAssertNil(dict[@"duration"]);
    XCTAssertNil(dict[@"beginTimestamp"]);
}

@end
