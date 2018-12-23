//
//  WhiteNativeApi.h
//  Pods
//
//  Created by leavesster on 2018/8/12.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WhiteRoomPhase) {
    WhiteRoomPhaseConnecting,           //正在连接
    WhiteRoomPhaseConnected,            //连接成功
    WhiteRoomPhaseReconnecting,         //正在尝试重新连接
    WhiteRoomPhaseDisconnecting,        //正在中断连接
    WhiteRoomPhaseDisconnected,         //已断开连接
};

@class WhiteRoomState, WhiteEvent;

@protocol WhiteRoomCallbackDelegate <NSObject>

@optional

/** 白板网络连接状态回调事件 */
- (void)firePhaseChanged:(WhiteRoomPhase)phase;

/** 白板当前任意RoomState属性变量变化时，回调 */
- (void)fireRoomStateChanged:(WhiteRoomState *)magixPhase;

- (void)fireBeingAbleToCommitChange:(BOOL)isAbleToCommit;

/** 白板失去连接回调，附带错误信息 */
- (void)fireDisconnectWithError:(NSString *)error;

/** 用户被远程服务器踢出房间，附带踢出原因 */
- (void)fireKickedWithReason:(NSString *)reason;

/** 用户错误事件捕获，附带用户 id，已经错误原因 */
- (void)fireCatchErrorWhenAppendFrame:(NSUInteger)userId error:(NSString *)error;

/**
 白板自定义事件回调，
 自定义事件参考: https://developer.herewhite.com/#/iOS_detail_api?id=%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B6%88%E6%81%AF
 */
- (void)fireMagixEvent:(WhiteEvent *)event;

- (NSString *)resourceInterrupter:(NSString *)url;

@end

@interface WhiteRoomCallbacks : NSObject

@property (nonatomic, weak) id<WhiteRoomCallbackDelegate> delegate;

@end
