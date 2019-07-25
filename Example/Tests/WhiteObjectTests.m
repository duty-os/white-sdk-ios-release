//
//  WhiteObjectTests.m
//  WhiteSDKPrivate_Tests
//
//  Created by yleaf on 2019/6/7.
//  Copyright © 2019 leavesster. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <WhiteSDK.h>

@interface CustomGlobalTestClass : WhiteGlobalState
@property (nonatomic, strong) NSString *name;
@end

@implementation CustomGlobalTestClass

@end



@interface WhiteObjectTests : XCTestCase

@end

@implementation WhiteObjectTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testWhiteEventConvertDict {
    WhiteEvent *event = [[WhiteEvent alloc] init];
    event.eventName = @"ee";
    event.payload = @{@"k": @"v"};
    NSDictionary *dict = [event jsonDict];
    
    WhiteEvent *event1 = [WhiteEvent modelWithJSON:dict];
    XCTAssertTrue([event1.payload isEqual:event.payload]);
    
    event1.payload = @"";
    XCTAssertFalse([event1.payload isEqual:event.payload]);
}

- (void)testWhiteEventConvertStr {
    WhiteEvent *event = [[WhiteEvent alloc] init];
    event.eventName = @"ee";
    event.payload = @"313131";
    NSDictionary *dict = [event jsonDict];
    
    WhiteEvent *event1 = [WhiteEvent modelWithJSON:dict];
    XCTAssertTrue([self whiteEventEqual:event event:event1]);

    event1.payload = @"";
    XCTAssertFalse([self whiteEventEqual:event event:event1]);
}

- (void)testWhiteEventConvertNum {
    WhiteEvent *event = [[WhiteEvent alloc] init];
    event.eventName = @"ee";
    NSInteger num = 333;
    event.payload = @(num);
    NSDictionary *dict = [event jsonDict];
    
    WhiteEvent *event1 = [WhiteEvent modelWithJSON:dict];
    XCTAssertTrue([self whiteEventEqual:event event:event1]);
    
    event1.payload = @"";
    XCTAssertFalse([self whiteEventEqual:event event:event1]);
}

- (BOOL)whiteEventEqual:(WhiteEvent *)event event:(WhiteEvent *)event1
{
    return [event.eventName isEqualToString:event1.eventName] && [event.payload isEqual:event1.payload];
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

- (void)testCustomGlobalState
{
    [WhiteDisplayerState setCustomGlobalStateClass:[CustomGlobalTestClass class]];
    
    // 不能直接初始化复制，直接从字典生成一个
    NSDictionary *dict = @{@"globalState": @{@"name": @"value"}};
    WhiteDisplayerState *result = [WhiteDisplayerState modelWithJSON:dict];
    
    XCTAssertNotNil(result.globalState);
    XCTAssertTrue([result.globalState isKindOfClass:[CustomGlobalTestClass class]]);
    XCTAssertTrue([[(CustomGlobalTestClass *)result.globalState name] isEqualToString:@"value"]);
}

- (void)testCustomGlobalStateInRoom
{
    [WhiteDisplayerState setCustomGlobalStateClass:[CustomGlobalTestClass class]];
    
    // 不能直接初始化复制，直接从字典生成一个
    NSDictionary *dict = @{@"globalState": @{@"name": @"value"}};
    WhiteRoomState *result = [WhiteRoomState modelWithJSON:dict];
    
    XCTAssertNotNil(result.globalState);
    XCTAssertTrue([result.globalState isKindOfClass:[CustomGlobalTestClass class]]);
    XCTAssertTrue([[(CustomGlobalTestClass *)result.globalState name] isEqualToString:@"value"]);
}

- (void)testCustomGlobalStateInReplayer
{
    [WhiteDisplayerState setCustomGlobalStateClass:[CustomGlobalTestClass class]];
    
    // 不能直接初始化复制，直接从字典生成一个
    NSDictionary *dict = @{@"globalState": @{@"name": @"value"}};
    WhitePlayerState *result = [WhitePlayerState modelWithJSON:dict];
    
    XCTAssertNotNil(result.globalState);
    XCTAssertTrue([result.globalState isKindOfClass:[CustomGlobalTestClass class]]);
    XCTAssertTrue([[(CustomGlobalTestClass *)result.globalState name] isEqualToString:@"value"]);
}

- (void)testMemberState
{
    WhiteMemberState *memberState = [[WhiteMemberState alloc] init];
    memberState.strokeWidth = @1;
    NSDictionary *dict1 = [memberState jsonDict];
    
    WhiteReadonlyMemberState *readonlyState = [WhiteReadonlyMemberState modelWithJSON:dict1];
    
    XCTAssertNotNil(readonlyState);
    XCTAssertNotNil(readonlyState.strokeWidth);
}

@end
