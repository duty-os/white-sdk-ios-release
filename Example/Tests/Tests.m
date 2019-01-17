//
//  WhiteSDKTests.m
//  WhiteSDKTests
//
//  Created by leavesster on 08/12/2018.
//  Copyright (c) 2018 leavesster. All rights reserved.
//

@import XCTest;

@interface Tests : XCTestCase

@end

#import <WhiteSDK.h>
#import "WhiteRoomViewController.h"

@interface Tests ()<WhiteRoomCallbackDelegate>
@property (nonatomic, strong) WhiteRoomViewController *vc;
@property (nonatomic, strong) WhiteRoom *room;

@property (nonatomic, strong) XCTestExpectation *exp;
@end

#import "WhiteCommandListController.h"

@implementation Tests

#pragma mark - WhiteRoomCallbackDelegate
- (void)firePhaseChanged:(WhiteRoomPhase)phase
{
    NSLog(@"%s, %ld", __FUNCTION__, (long)phase);
}

- (void)fireRoomStateChanged:(WhiteRoomState *)magixPhase;
{
    NSLog(@"%s, %@", __func__, [magixPhase jsonString]);
}

- (void)fireBeingAbleToCommitChange:(BOOL)isAbleToCommit
{
    NSLog(@"%s, %d", __func__, isAbleToCommit);
}

- (void)fireDisconnectWithError:(NSString *)error
{
    NSLog(@"%s, %@", __func__, error);
    
}

- (void)fireKickedWithReason:(NSString *)reason
{
    NSLog(@"%s, %@", __func__, reason);
}

- (void)fireCatchErrorWhenAppendFrame:(NSUInteger)userId error:(NSString *)error
{
    NSLog(@"%s, %luu %@", __func__,(unsigned long) (unsigned long)userId, error);
}

- (void)fireMagixEvent:(WhiteEvent *)event
{
    [self.exp fulfill];
    NSLog(@"fireMagixEvent: %@", [event jsonString]);
}

#pragma mark - Test
- (void)setUp
{
    [super setUp];
    self.vc = [[WhiteRoomViewController alloc] init];
    self.vc.roomCallbackDelegate = self;
    __unused UIView *view = [self.vc view];
    
    XCTestExpectation *exp = [self expectationWithDescription:@"createRoom"];

    __weak typeof(self)weakSelf = self;
    self.vc.roomBlock = ^(WhiteRoom *room, NSError *error) {
        XCTAssert(room);
        weakSelf.room = room;
        [exp fulfill];
    };
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}


- (void)tearDown
{
    [super tearDown];
}

#pragma mark - Room

- (void)testRoom
{
    XCTAssertNotNil(self.vc.room);
}

#pragma mark - Set API

- (void)testSetViewMode
{
    [self.room setViewMode:WhiteViewModeBroadcaster];
}

- (void)testMemberState
{
    WhiteMemberState *mState = [[WhiteMemberState alloc] init];
    mState.currentApplianceName = ApplianceRectangle;
    [self.room setMemberState:mState];
}

- (void)testGlobalState
{
    WhiteGlobalState *gState = [[WhiteGlobalState alloc] init];
    [gState setCurrentSceneIndex:3];
    [self.room setGlobalState:gState];
}

- (void)testPushPptPages
{
    WhitePptPage *pptPage = [[WhitePptPage alloc] init];
    pptPage.src = @"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/image.png";
    pptPage.width = 600;
    pptPage.height = 600;
    [self.room pushPptPages:@[pptPage]];
}

#pragma mark - Get API testing

- (void)testGetPptImagesWithResult
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getPptImagesWithResult:^(NSArray<NSString *> *pptPages) {
        XCTAssertTrue([pptPages isKindOfClass:[NSArray class]]);
        NSLog(@"%@", pptPages);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testGetGlobalState
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getGlobalStateWithResult:^(WhiteGlobalState *state) {
        XCTAssertTrue([state isKindOfClass:[WhiteGlobalState class]]);
        NSLog(@"%@", [state jsonString]);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testGetMemberState
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getMemberStateWithResult:^(WhiteMemberState *state) {
        XCTAssertTrue([state isKindOfClass:[WhiteMemberState class]]);
        NSLog(@"%@", [state jsonString]);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testBroadcastState
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getBroadcastStateWithResult:^(WhiteBroadcastState *state) {
        XCTAssertTrue([state isKindOfClass:[WhiteBroadcastState class]]);
        NSLog(@"%@", [state jsonString]);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testRoomMember
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getRoomMembersWithResult:^(NSArray<WhiteRoomMember *> *roomMembers) {
        for (WhiteRoomMember *member in roomMembers) {
            NSLog(@"%@", [member jsonString]);
            XCTAssertTrue([member isKindOfClass:[WhiteRoomMember class]]);
        }
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testRoomMemberFireMagixEvent
{
    self.exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    NSDictionary *dict = @{@"test": @"1234"};
    [self.room dispatchMagixEvent:WhiteCommandCustomEvent payload:dict];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

@end

