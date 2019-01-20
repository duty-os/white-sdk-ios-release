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
    
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    __weak typeof(self)weakSelf = self;
    self.vc.roomBlock = ^(WhiteRoom *room, NSError *error) {
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

- (void)testSetBroadcaster
{
    [self viewModeTest:WhiteViewModeBroadcaster];
}

//单个用户无法成为观众
//- (void)testSetFollower
//{
//    [self.room setViewMode:WhiteViewModeFollower];
//    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
//    [self.room getBroadcastStateWithResult:^(WhiteBroadcastState *state) {
//        XCTAssertTrue([state isKindOfClass:[WhiteBroadcastState class]]);
//        XCTAssertEqual(state.viewMode, WhiteViewModeFollower);
//        [exp fulfill];
//    }];
//
//    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"%s error: %@", __FUNCTION__, error);
//        }
//    }];
//}

- (void)testSetFreedom
{
    [self viewModeTest:WhiteViewModeFreedom];
}

- (void)viewModeTest:(WhiteViewMode)viewMode
{
    [self.room setViewMode:viewMode];
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getBroadcastStateWithResult:^(WhiteBroadcastState *state) {
        XCTAssertTrue([state isKindOfClass:[WhiteBroadcastState class]]);
        XCTAssertTrue(state.viewMode == viewMode);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testSetMemberState
{
    WhiteMemberState *mState = [[WhiteMemberState alloc] init];
    mState.currentApplianceName = ApplianceRectangle;
    [self.room setMemberState:mState];
    
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getMemberStateWithResult:^(WhiteMemberState *state) {
        XCTAssertTrue([state isKindOfClass:[WhiteMemberState class]]);
        XCTAssertTrue([state.currentApplianceName isEqualToString:mState.currentApplianceName]);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testSetGlobalState
{
    WhitePptPage *pptPage = [[WhitePptPage alloc] init];
    pptPage.src = @"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/image.png";
    pptPage.width = 600;
    pptPage.height = 600;
    [self.room pushPptPages:@[pptPage]];

    WhiteGlobalState *gState = [[WhiteGlobalState alloc] init];
    [gState setCurrentSceneIndex:1];
    [self.room setGlobalState:gState];
    
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getGlobalStateWithResult:^(WhiteGlobalState *state) {
        XCTAssertTrue([state isKindOfClass:[WhiteGlobalState class]]);
        XCTAssertEqual(state.currentSceneIndex, 1);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testPptImages
{
    WhitePptPage *ppt = [[WhitePptPage alloc] init];
    ppt.src = @"https://white-pan-cn.oss-cn-hangzhou.aliyuncs.com/124/image/image.png";
    ppt.width = 600;
    ppt.height = 600;
    [self.room pushPptPages:@[ppt]];
    
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getPptImagesWithResult:^(NSArray<NSString *> *pptPages) {
        XCTAssertTrue([[pptPages lastObject] isEqualToString:ppt.src]);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testRoomMember
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getRoomMembersWithResult:^(NSArray<WhiteRoomMember *> *roomMembers) {
        for (WhiteRoomMember *member in roomMembers) {
            XCTAssertTrue([member isKindOfClass:[WhiteRoomMember class]]);
            NSLog(@"%s %@", __FUNCTION__, [member jsonString]);
        }
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
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
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

@end

