//
//  WhitePlayerEvent.h
//  WhiteSDK
//
//  Created by yleaf on 2019/3/1.
//

#import <Foundation/Foundation.h>
#import "WhiteObserverState.h"
#import "WhitePlayerState.h"
#import "WhitePlayerConsts.h"
#import "WhiteUpdateCursor.h"
#import "WhiteEvent.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WhitePlayerEventDelegate <NSObject>

@optional

/** 播放状态切换回调 */
- (void)phaseChanged:(WhitePlayerPhase)phase;
/** 首帧加载回调 */
- (void)loadFirstFrame;
/** 分片切换回调，需要了解分片机制。目前无实际用途 */
- (void)sliceChanged:(NSString *)slice;
/** 播放中，状态出现变化的回调 */
- (void)playerStateChanged:(WhitePlayerState *)modifyState;
/** 出错暂停 */
- (void)stoppedWithError:(NSError *)error;
/** 进度时间变化 */
- (void)scheduleTimeChanged:(NSTimeInterval)time;
/** 添加帧出错 */
- (void)errorWhenAppendFrame:(NSError *)error;
/** 渲染时，出错 */
- (void)errorWhenRender:(NSError *)error;
/**
 白板自定义事件回调，
 自定义事件参考文档，或者 RoomTests 代码
 */
- (void)fireMagixEvent:(WhiteEvent *)event;
/** 用户头像信息变化 */
- (void)cursorViewsUpdate:(WhiteUpdateCursor *)updateCursor;

@end

@interface WhitePlayerEvent : NSObject

@property (nonatomic, weak, nullable) id<WhitePlayerEventDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
