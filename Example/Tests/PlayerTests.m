//
//  PlayerTests.m
//  WhiteSDKPrivate_Example
//
//  Created by yleaf on 2019/3/8.
//  Copyright © 2019 leavesster. All rights reserved.
//

@import XCTest;
#import <WhiteSDK.h>
#import "WhitePlayerViewController.h"

@interface PlayerTests : XCTestCase<WhitePlayerEventDelegate, WhiteCommonCallbackDelegate>

@property (nonatomic, strong) WhitePlayerViewController *vc;
@property (nonatomic, strong) WhitePlayer *player;

@property (nonatomic, strong) XCTestExpectation *exp;
@property (nonatomic, copy) dispatch_block_t loadFirstFrameBlock;
@property (nonatomic, copy) void (^seekBlock)(NSTimeInterval time);
@property (nonatomic, copy) dispatch_block_t playBlock;
@property (nonatomic, copy) dispatch_block_t pauseBlock;

@end


@implementation PlayerTests
#pragma mark - Const
static NSTimeInterval kTimeout = 30;

#pragma mark - Test
- (void)setUp
{
    [super setUp];
    self.vc = [[WhitePlayerViewController alloc] init];
    self.vc.roomUuid = @"1bd317e6fba74a69a81eccbd4c79db2c";
    self.vc.eventDelegate = self;
    self.vc.commonDelegate = self;

    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    __weak typeof(self)weakSelf = self;
    self.vc.playBlock = ^(WhitePlayer * _Nullable player, NSError * _Nullable eroror) {
        id self = weakSelf;
        weakSelf.player = player;
        XCTAssertNotNil(player);
        [exp fulfill];
    };
    
    __unused UIView *view = [self.vc view];
    //需要模拟UI 界面操作，否则 player 无法进行播放
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
    [super tearDown];
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([nav isKindOfClass:[UINavigationController class]]) {
        [nav popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - Private
- (void)setupPlayer
{
    [self.player seekToScheduleTime:0];
    [self.player play];
}

#pragma mark - Player Testing

- (void)testPlay
{
    self.exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    __weak typeof(self)weakSelf = self;
    self.playBlock = ^{
        [weakSelf.exp fulfill];
    };
    [self setupPlayer];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testPause
{
    self.exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    
    __weak typeof(self)weakSelf = self;
    
    self.playBlock = ^{
        [weakSelf.player pause];
    };
    
    self.pauseBlock = ^{
        [weakSelf.exp fulfill];
    };
    
    [self setupPlayer];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testSeekToScheduleTime
{
    self.exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];

    CGFloat expTime = 5;
    __weak typeof(self)weakSelf = self;
    self.seekBlock = ^(NSTimeInterval time) {
        if (time == expTime) {
            [weakSelf.exp fulfill];
        } else if (time < expTime) {
            id self = weakSelf;
            XCTFail(@"seek 失败");
        }
    };
    
    //先从后期到前面，避免自然 play 时触发到时间
    [self.player seekToScheduleTime:expTime];
    [self.player play];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testSetFollowUserId
{
    //TODO:需要特殊白板
}

- (void)testSetObserverMode
{
    self.exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [self.player setObserverMode:WhiteObserverModeFreedom];
    
    __weak typeof(self)weakSelf = self;
    self.playBlock = ^{
        [weakSelf.player getPlayerStateWithResult:^(WhitePlayerState * _Nonnull state) {
            id self = weakSelf;
            XCTAssertTrue(state.observerState.mode == WhiteObserverModeFreedom);
            [weakSelf.exp fulfill];
        }];
    };
    
    [self setupPlayer];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testGetPhase
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    __weak typeof(self)weakSelf = self;
    [weakSelf.player getPhaseWithResult:^(WhitePlayerPhase phase) {
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testGetPlayerState
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    __weak typeof(self)weakSelf = self;
    self.loadFirstFrameBlock = ^{
        [weakSelf.player getPlayerStateWithResult:^(WhitePlayerState * _Nonnull state) {
            [exp fulfill];
        }];
    };
    
    [self setupPlayer];

    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

- (void)testGetPlayerTimeInfo
{
    XCTestExpectation *exp = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [self setupPlayer];
    
    [self.player getPlayerTimeInfoWithResult:^(WhitePlayerTimeInfo * _Nonnull info) {
        XCTAssertNotNil(info);
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:kTimeout handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - WhitePlayerEventDelegate

- (void)phaseChanged:(WhitePlayerPhase)phase
{
    NSLog(@"PlayerTest %s %ld", __FUNCTION__, (long)phase);
    if (phase == WhitePlayerPhasePlaying && self.playBlock) {
        self.playBlock();
    } else if (phase == WhitePlayerPhasePause && self.pauseBlock) {
        self.pauseBlock();
    }
}

- (void)loadFirstFrame
{
    NSLog(@"PlayerTest %s", __FUNCTION__);
    if (self.loadFirstFrameBlock) {
        self.loadFirstFrameBlock();
    }
}

- (void)sliceChanged:(NSString *)slice
{
    NSLog(@"PlayerTest %s slice:%@", __FUNCTION__, slice);
}

- (void)playerStateChanged:(WhitePlayerState *)modifyState
{
    NSString *str = [modifyState jsonString];
    NSLog(@"PlayerTest %s state:%@", __FUNCTION__, str);
}

- (void)stoppedWithError:(NSError *)error
{
    NSLog(@"PlayerTest %s error:%@", __FUNCTION__, error);
}

- (void)scheduleTimeChanged:(NSTimeInterval)time
{
    NSLog(@"PlayerTest %s time:%f", __FUNCTION__, (double)time);
    if (self.seekBlock) {
        self.seekBlock(time);
    }
}

#pragma mark - WhiteCommonCallback
- (NSString *)urlInterrupter:(NSString *)url
{
    return @"https://white-pan-cn.oss-cn-hangzhou.aliyuncs.com/124/image/image.png";
}

@end
