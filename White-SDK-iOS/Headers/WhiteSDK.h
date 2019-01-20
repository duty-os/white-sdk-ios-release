//
//  WhiteSDK.h
//  Pods-white-ios-sdk_Example
//
//  Created by leavesster on 2018/8/11.
//

#import <Foundation/Foundation.h>
#import "WhiteRoom.h"
#import "WhiteRoomCallbacks.h"
#import "WhiteBoardView.h"
#import "WhiteSdkConfiguration.h"


/**
 单独实例，为了能够进行使用加入房间 API，进行重连房间操作，最好有当前 ViewController 持有。
 */
@interface WhiteSDK : NSObject

- (instancetype)initWithBoardView:(WhiteBoardView *)boardView config:(WhiteSdkConfiguration *)config callbackDelegate:(id<WhiteRoomCallbackDelegate>)callbackDelegate;

- (instancetype)initWithWhiteBoardView:(WhiteBoardView *)boardView config:(WhiteSdkConfiguration *)config DEPRECATED_MSG_ATTRIBUTE("initWithBoardView:config:callbackDelegate:");

/** 加入房间API
 网络出现问题时，白板会自行尝试重连操作，当重连3次失败了，会处于断开状态；此时可以手动调用该方法手动加入房间。
 */
- (void)joinRoomWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken completionHandler:(void (^)(BOOL, WhiteRoom *, NSError *))completionHander;

- (void)joinRoomWithRoomUuid:(NSString *)roomUuid roomToken:(NSString *)roomToken callbacks:(id<WhiteRoomCallbackDelegate>)callbacks completionHandler:(void (^) (BOOL success, WhiteRoom *room, NSError *error))completionHander DEPRECATED_MSG_ATTRIBUTE("initWithBoardView:config:");

@end
