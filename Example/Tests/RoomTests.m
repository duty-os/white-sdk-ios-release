//
//  WhiteSDKTests.m
//  WhiteSDKTests
//
//  Created by leavesster on 08/12/2018.
//  Copyright (c) 2018 leavesster. All rights reserved.
//

@import XCTest;
#import <WhiteSDK.h>
#import "WhiteRoomViewController.h"

@interface RoomTests : XCTestCase<WhiteRoomCallbackDelegate, WhiteCommonCallbackDelegate>
@property (nonatomic, strong) WhiteRoomViewController *vc;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) XCTestExpectation *exp;
@end


@implementation RoomTests
#pragma mark - Test
- (void)setUp
{
    [super setUp];
    self.vc = [[WhiteRoomViewController alloc] init];
    self.vc.roomCallbackDelegate = self;
    self.vc.commonDelegate = self;
    __unused UIView *view = [self.vc view];
    
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    __weak typeof(self)weakSelf = self;
    self.vc.roomBlock = ^(WhiteRoom *room, NSError *error) {
        typeof(self)self = weakSelf;
        if (room) {
            weakSelf.room = room;
        } else {
            XCTFail(@"房间创建失败");
        }
        [exp fulfill];
    };
    
    //部分API，需要 Webview 在视图栈中
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([nav isKindOfClass:[UINavigationController class]]) {
        [nav pushViewController:self.vc animated:YES];
    }
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}


- (void)tearDown
{
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([nav isKindOfClass:[UINavigationController class]]) {
        [nav popToRootViewControllerAnimated:YES];
    }
    [super tearDown];
}

#pragma mark - Consts

static NSString * const kTestingCustomEventName = @"TestingCustomEventName";
static NSTimeInterval kTimeout = 30;
#define CustomEventPayload @{@"test": @"1234"}

#pragma mark - Testing
- (void)testRoom
{
    XCTAssertNotNil(self.vc.room);
}

- (void)testSetMemberState
{
    WhiteMemberState *mState = [[WhiteMemberState alloc] init];
    mState.currentApplianceName = ApplianceRectangle;
    mState.strokeColor = @[@12, @24, @36];
    [self.room setMemberState:mState];
    
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getMemberStateWithResult:^(WhiteMemberState *state) {
        XCTAssertTrue([state isKindOfClass:[WhiteMemberState class]]);
        XCTAssertTrue([state.currentApplianceName isEqualToString:mState.currentApplianceName]);
        for (NSInteger i=0; i < [state.strokeColor count]; i++) {
            XCTAssertTrue([mState.strokeColor[i] isEqualToNumber:state.strokeColor[i]]);
        }
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testSetBroadcaster
{
    //单个用户无法成为观众，只能测试主播
    [self viewModeTest:WhiteViewModeBroadcaster];
}

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
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testZoomChange
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    CGFloat zoomScale = 5;
    [self.room zoomChange:0.5];
    [self.room zoomChange:zoomScale];
    
    // 2.0.4 开始，可以瞬间获得
    [self.room getZoomScaleWithResult:^(CGFloat scale) {
        XCTAssertTrue(scale == zoomScale);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testDisableOperations
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room disableOperations:YES];
    
    // TODO: 增加获取 disableOperation 操作
    
    [exp fulfill];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}


/**
 put and setScene
 */
- (void)testSceneAPI
{
    WhitePptPage *pptPage = [[WhitePptPage alloc] init];
    pptPage.src = @"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/alin-rusu-1239275-unsplash_opt.jpg";
    pptPage.width = 400;
    pptPage.height = 600;
    
    //因为这个场景目录，只插入了一页
    NSInteger index = 0;
    
    WhiteScene *scene = [[WhiteScene alloc] initWithName:@"opt" ppt:pptPage];
    [self.room putScenes:@"/ppt" scenes:@[scene] index:index];
    [self.room setScenePath:@"/ppt/opt"];
    
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [self.room getSceneStateWithResult:^(WhiteSceneState * _Nonnull state) {
        XCTAssertTrue([state.scenePath isEqualToString:@"/ppt/opt"]);
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self.room getScenesWithResult:^(NSArray<WhiteScene *> * _Nonnull scenes) {
        XCTAssertTrue([scenes[index].ppt.src isEqualToString:pptPage.src]);
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [exp fulfill];
    });
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testSetScenePathFail
{
    WhitePptPage *pptPage = [[WhitePptPage alloc] init];
    pptPage.src = @"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/alin-rusu-1239275-unsplash_opt.jpg";
    pptPage.width = 400;
    pptPage.height = 600;
    WhiteScene *scene = [[WhiteScene alloc] initWithName:@"opt" ppt:pptPage];
    [self.room putScenes:@"/ppt" scenes:@[scene] index:0];
    
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    //传入错误的路径，获取错误回调
    [self.room setScenePath:@"ppt/opt" completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            NSLog(@"setScenePath fail");
            [exp fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testPptImages
{
    WhitePptPage *pptPage = [[WhitePptPage alloc] init];
    pptPage.src = @"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/alin-rusu-1239275-unsplash_opt.jpg";
    pptPage.width = 400;
    pptPage.height = 600;
    WhiteScene *scene = [[WhiteScene alloc] initWithName:@"opt" ppt:pptPage];
    [self.room putScenes:@"/ppt" scenes:@[scene] index:0];
    [self.room setScenePath:@"/ppt/opt"];
    
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getSceneStateWithResult:^(WhiteSceneState * _Nonnull state) {
        NSLog(@"SceneState: %@", [state jsonString]);
    }];
    
    [self.room getScenesWithResult:^(NSArray<WhiteScene *> * _Nonnull scenes) {
        XCTAssertTrue([[scenes lastObject].ppt.src isEqualToString:pptPage.src]);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testInsertImage
{
    self.exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    WhiteImageInformation *info = [[WhiteImageInformation alloc] init];
    info.width = 200;
    info.height = 300;
    info.uuid = @"WhiteImageInformation";
    [self.room insertImage:info src:@"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/alin-rusu-1239275-unsplash_opt.jpg"];
    
    // 在回调urlInterrupt API 中收到回调，self.exp 就会释放
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testCleanSceneNoPpt
{
    [self cleanScene:NO];
}

- (void)testCleanSceneRetainPpt
{
    [self cleanScene:YES];
}

- (void)cleanScene:(BOOL)retainPPT
{
    WhitePptPage *pptPage = [[WhitePptPage alloc] init];
    pptPage.src = @"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/alin-rusu-1239275-unsplash_opt.jpg";
    pptPage.width = 400;
    pptPage.height = 600;
    WhiteScene *scene = [[WhiteScene alloc] initWithName:@"opt" ppt:pptPage];
    [self.room putScenes:@"/ppt" scenes:@[scene] index:0];
    [self.room setScenePath:@"/ppt/opt"];
    
    [self.room cleanScene:retainPPT];
    
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getSceneStateWithResult:^(WhiteSceneState * _Nonnull state) {
        WhiteScene *current = state.scenes[state.index];
        if (retainPPT) {
            XCTAssertTrue([current.ppt.src isEqualToString:pptPage.src]);
            XCTAssertTrue(current.componentsCount == 1);
        } else {
            XCTAssertNil(current.ppt);
            XCTAssertTrue(current.componentsCount == 0);
        }
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testGetRoomMember
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getRoomMembersWithResult:^(NSArray<WhiteRoomMember *> *roomMembers) {
        for (WhiteRoomMember *member in roomMembers) {
            XCTAssertTrue([member isKindOfClass:[WhiteRoomMember class]]);
            NSLog(@"%s %@", __FUNCTION__, [member jsonString]);
        }
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testGetRoomState
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    [self.room getRoomStateWithResult:^(WhiteRoomState * _Nonnull state) {
        if ([state isKindOfClass:[WhiteRoomState class]]) {
            [exp fulfill];
        } else {
            XCTFail(@"获取失败");
        }
    }];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

- (void)testCustomEvent
{
    self.exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    NSDictionary *dict = CustomEventPayload;
    
    [self.room addMagixEventListener:kTestingCustomEventName];
    [self.room dispatchMagixEvent:kTestingCustomEventName payload:dict];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%s error: %@", __FUNCTION__, error);
        }
    }];
}

#pragma mark - WhiteRoomCallbackDelegate
- (void)firePhaseChanged:(WhiteRoomPhase)phase
{
    NSLog(@"%s, %ld", __func__, (long)phase);
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
    NSLog(@"%s, %lu %@", __func__, (unsigned long)userId, error);
}

- (void)fireMagixEvent:(WhiteEvent *)event
{
    XCTAssertTrue([event.eventName isEqualToString:kTestingCustomEventName]);
    XCTAssertTrue([event.payload isEqualToDictionary:CustomEventPayload]);
    NSLog(@"fireMagixEvent: %@", [event jsonString]);
    [self.exp fulfill];
}

#pragma mark - WhiteRoomCallbackDelegate
- (void)throwError:(NSError *)error
{
    NSLog(@"throwError: %@", error.userInfo);
}

- (NSString *)urlInterrupter:(NSString *)url
{
    if (self.exp) {
        [self.exp fulfill];
    }
    return url;
}

@end

