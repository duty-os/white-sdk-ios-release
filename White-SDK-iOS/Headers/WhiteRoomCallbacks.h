//
//  WhiteNativeApi.h
//  Pods
//
//  Created by leavesster on 2018/8/12.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WhiteRoomPhase) {
    WhiteRoomPhaseReady,
    WhiteRoomPhaseConnecting,
    WhiteRoomPhaseConnected,
    WhiteRoomPhaseReconnecting,
    WhiteRoomPhaseDisconnecting,
    WhiteRoomPhaseClosed,
};

@class WhiteRoomState, WhiteEvent;

@protocol WhiteRoomCallbackDelegate <NSObject>
/** 白板网络连接状态回调事件 */
- (void)firePhaseChanged:(WhiteRoomPhase)phase;
/** 白板当前任意RoomState属性变量变化时，回调 */
- (void)fireRoomStateChanged:(WhiteRoomState *)magixPhase;
- (void)fireBeingAbleToCommitChange:(BOOL)isAbleToCommit;
/** 白板失去连接回调 */
- (void)fireDisconnectWithError:(NSString *)error;
/** 用户被远程服务器踢出房间 */
- (void)fireKickedWithReason:(NSString *)reason;
/** 用户错误事件捕获 */
- (void)fireCatchErrorWhenAppendFrame:(NSUInteger)userId error:(NSString *)error;
/** 白板自定义事件回调 */
- (void)fireMagixEvent:(WhiteEvent *)event;
@end

@interface WhiteRoomCallbacks : NSObject

@property (nonatomic, weak) id<WhiteRoomCallbackDelegate> delegate;

@end
