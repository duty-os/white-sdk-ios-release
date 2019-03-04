//
//  WhitePlayerViewController.m
//  WhiteSDKPrivate_Example
//
//  Created by yleaf on 2019/3/2.
//  Copyright © 2019 leavesster. All rights reserved.
//

#import "WhitePlayerViewController.h"
#import "WhiteSDK.h"

@interface WhitePlayerViewController ()<WhiteCommonCallbackDelegate, WhitePlayerEventDelegate>
@property (nonatomic, strong) WhiteSDK *sdk;
@property (nonatomic, nullable, strong) WhitePlayer *player;
@property (nonatomic, strong) WhiteBoardView *boardView;
@end

#import <Masonry/Masonry.h>

@implementation WhitePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPlayer];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"重连", nil) style:UIBarButtonItemStylePlain target:self action:@selector(initPlayer)];
}

- (void)initPlayer
{
    WhiteSdkConfiguration *config = [WhiteSdkConfiguration defaultConfig];
    config.enableDebug = YES;
    self.sdk = [[WhiteSDK alloc] initWithWhiteBoardView:self.boardView config:config commonCallbackDelegate:self.commonDelegate];
    WhitePlayerConfig *playerConfig = [[WhitePlayerConfig alloc] initWithRoom:self.roomUuid];
    playerConfig.audioUrl = @"https://d2zihajmogu5jn.cloudfront.net/bipbop-advanced/bipbop_16x9_variant.m3u8";
    [self.sdk createReplayerWithConfig:playerConfig callbacks:self.eventDelegate completionHandler:^(BOOL success, WhitePlayer * _Nonnull player, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"创建回放房间失败 error:%@", [error localizedDescription]);
        } else {
            self.player = player;
            NSLog(@"创建回放房间成功，开始回放");
            [self.player seekToScheduleTime:0];
            [self.player play];
        }
    }];
}

#pragma mark - CallbackDelegate
- (id<WhiteCommonCallbackDelegate>)commonDelegate
{
    if (!_commonDelegate) {
        _commonDelegate = self;
    }
    return _commonDelegate;
}

- (id<WhitePlayerEventDelegate>)eventDelegate
{
    if (!_eventDelegate) {
        _eventDelegate = self;
    }
    return _eventDelegate;
}

#pragma mark - WhitePlayerEventDelegate

- (void)phaseChanged:(WhitePlayerPhase)phase
{
    NSLog(@"player %s %ld", __FUNCTION__, (long)phase);
}

- (void)loadFirstFrame
{
    NSLog(@"player %s", __FUNCTION__);
}

- (void)sliceChanged:(NSString *)slice
{
    NSLog(@"player %s slice:%@", __FUNCTION__, slice);
}

- (void)playerStateChanged:(WhitePlayerState *)modifyState
{
    NSString *str = [modifyState jsonString];
    NSLog(@"player %s state:%@", __FUNCTION__, str);
}

- (void)stoppedWithError:(NSError *)error
{
    NSLog(@"player %s error:%@", __FUNCTION__, error);
}

- (void)scheduleTimeChanged:(NSTimeInterval)time
{
    NSLog(@"player %s time:%ld", __FUNCTION__, (long)time);
}

#pragma mark - WhiteRoomCallbackDelegate
- (NSString *)urlInterrupter:(NSString *)url
{
    return @"https://white-pan-cn.oss-cn-hangzhou.aliyuncs.com/124/image/image.png";
}

@end
