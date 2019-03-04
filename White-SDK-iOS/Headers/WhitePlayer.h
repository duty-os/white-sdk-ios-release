//
//  WhitePlayer.h
//  WhiteSDK
//
//  Created by yleaf on 2019/2/28.
//

#import <Foundation/Foundation.h>
#import "WhitePlayerConsts.h"
#import "WhitePlayerState.h"
#import "WhiteObserverState.h"
#import "WhitePlayerTimeInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhitePlayer : NSObject

@property (nonatomic, copy, readonly) NSString *uuid;

#pragma mark - action API

- (void)play;
- (void)pause;
//stop 后，player 资源会被释放。需要重新创建WhitePlayer实例，才可以重新播放
- (void)stop;
//跳转至特定时间
- (void)seekToScheduleTime:(NSTimeInterval)beginTime;
//设置查看模式
- (void)setObserMode:(WhiteObserverMode)mode;
//设置跟随的用户
- (void)setFollowUserId:(NSInteger)userId;

#pragma mark - get API

- (void)getPhaseWithResult:(void (^)(WhitePlayerPhase phase))result;
- (void)getPlayerStateWithResult:(void (^) (WhitePlayerState *state))result;
- (void)getPlayerTimeInfoWithResult:(void (^) (WhitePlayerTimeInfo *info))result;

@end

NS_ASSUME_NONNULL_END
