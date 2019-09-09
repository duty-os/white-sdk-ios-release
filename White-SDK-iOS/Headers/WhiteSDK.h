//
//  WhiteSDK.h
//  Pods-white-ios-sdk_Example
//
//  Created by leavesster on 2018/8/11.
//

#import <Foundation/Foundation.h>
#import "WhiteDisplayer.h"
#import "WhiteCommonCallbacks.h"
#import "WhiteConfig.h"
#import "WhiteRoom.h"
#import "WhiteRoomConfig.h"
#import "WhiteRoomCallbacks.h"
#import "WhitePlayer.h"
#import "WhitePlayerEvent.h"
#import "WhitePlayerConfig.h"
#import "WhiteBoardView.h"
#import "WhiteSdkConfiguration.h"
#import "WhiteConverter.h"
#import "WhiteCameraBound.h"

NS_ASSUME_NONNULL_BEGIN
/**
 非单例，一个 SDK 实例绑定，为了能够进行重连房间操作，最好由当前 ViewController 持有。
 */
@interface WhiteSDK : NSObject


/** White SDK 版本号 */
+ (NSString *)version;


/** 推荐初始化方法,commonCallback 为Room 与 Player 都支持的h callback */
- (instancetype)initWithWhiteBoardView:(WhiteBoardView *)boardView config:(WhiteSdkConfiguration *)config commonCallbackDelegate:(nullable id<WhiteCommonCallbackDelegate>)callback;

- (instancetype)initWithWhiteBoardView:(WhiteBoardView *)boardView config:(WhiteSdkConfiguration *)config DEPRECATED_MSG_ATTRIBUTE("initWithWhiteBoardView:config:commonCallbackDelegate");
/** 该 callback 对应的是 Room 的回调事件 */
- (instancetype)initWithBoardView:(WhiteBoardView *)boardView config:(WhiteSdkConfiguration *)config callbackDelegate:(nullable id<WhiteRoomCallbackDelegate>)callbackDelegate DEPRECATED_MSG_ATTRIBUTE("initWithWhiteBoardView:config:commonCallbackDelegate");

#pragma mark - CommonCallback
/** 为空，则移除原来的 CommonCallbacks */
- (void)setCommonCallbackDelegate:(nullable id<WhiteCommonCallbackDelegate>)callbackDelegate;

#pragma mark - Room API

/** 重连时，使用以下任意两个 API，不需要传入 callbacks，否则重连成功前，无法接受到事件连接的回调 */
- (void)joinRoomWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken completionHandler:(void (^)(BOOL success, WhiteRoom * _Nullable room, NSError * _Nullable error))completionHandler;
- (void)joinRoomWithRoomUuid:(NSString *)roomUuid roomToken:(NSString *)roomToken callbacks:(nullable id<WhiteRoomCallbackDelegate>)callbacks completionHandler:(void (^) (BOOL success, WhiteRoom * _Nullable room, NSError * _Nullable error))completionHandler;

- (void)joinRoomWithConfig:(WhiteRoomConfig *)config callbacks:(nullable id<WhiteRoomCallbackDelegate>)callbacks completionHandler:(void (^) (BOOL success, WhiteRoom * _Nullable room, NSError * _Nullable error))completionHandler;

#pragma mark - Player
- (void)createReplayerWithConfig:(WhitePlayerConfig *)config callbacks:(nullable id<WhitePlayerEventDelegate>)eventCallbacks completionHandler:(void (^) (BOOL success, WhitePlayer * _Nullable player, NSError * _Nullable error))completionHandler;

@end
NS_ASSUME_NONNULL_END
