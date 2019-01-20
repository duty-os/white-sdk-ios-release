//
//  WhiteNativeApi.h
//  Pods
//
//  Created by leavesster on 2018/8/12.
//

#import <Foundation/Foundation.h>

#pragma mark - ENUM

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

/**
 白板中RoomState属性，发生变化时，会触发该回调。
 注意：主动设置的 RoomState，不会触发该回调。
 目前有个别 state 内容，主动调用时，也会触发。后续版本会修复这个问题。
 @param modifyState 发生变化的 RoomState 内容
 */
- (void)fireRoomStateChanged:(WhiteRoomState *)modifyState;

- (void)fireBeingAbleToCommitChange:(BOOL)isAbleToCommit;

/** 白板失去连接回调，附带错误信息 */
- (void)fireDisconnectWithError:(NSString *)error;

/** 用户被远程服务器踢出房间，附带踢出原因 */
- (void)fireKickedWithReason:(NSString *)reason;

/** 用户错误事件捕获，附带用户 id，以及错误原因 */
- (void)fireCatchErrorWhenAppendFrame:(NSUInteger)userId error:(NSString *)error;

/**
 白板自定义事件回调，
 自定义事件参考: https://developer.herewhite.com/#/iOS_detail_api?id=%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B6%88%E6%81%AF
 */
- (void)fireMagixEvent:(WhiteEvent *)event;


@optional

/*
 调用插入图片API时，可以通过此方法，对使用插入图片API(completeImageUploadWithUuid:src:) 中，传入的 src 进行修改。
 该方法会被频繁调用，执行应尽可能快返回；如果没有对应需求，最好不要实现该方法。
 如果需要该 API，最好使用最新的 SDK 初始化方法初始化 WhiteSDK。
 */
- (NSString *)urlInterrupter:(NSString *)url;

@end

#pragma mark - WhiteRoomCallbacks

@interface WhiteRoomCallbacks : NSObject

@property (nonatomic, weak) id<WhiteRoomCallbackDelegate> delegate;


@end
