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

/**
 跳转到特定时间戳
 FIXME:目前，带音频时，不能 seek 到0以外的时间

 @param beginTime 开始时间（秒）
 */
- (void)seekToScheduleTime:(NSTimeInterval)beginTime;
//设置查看模式
- (void)setObserverMode:(WhiteObserverMode)mode;

#pragma mark - custom event
- (void)addMagixEventListener:(NSString *)eventName;
- (void)removeMagixEventListener:(NSString *)eventName;

#pragma mark - get API


/**
 目前：初始状态为 WhitePlayerPhaseWaitingFirstFrame

 当 WhitePlayerPhaseWaitingFirstFrame 时，调用 getPlayerStateWithResult 返回值可能为空。
 */
- (void)getPhaseWithResult:(void (^)(WhitePlayerPhase phase))result;

/**
 当 phase 状态为 WhitePlayerPhaseWaitingFirstFrame
 回调得到的数据是空的
 */
- (void)getPlayerStateWithResult:(void (^)(WhitePlayerState * _Nullable state))result;

- (void)getPlayerTimeInfoWithResult:(void (^)(WhitePlayerTimeInfo *info))result;

@end

NS_ASSUME_NONNULL_END
