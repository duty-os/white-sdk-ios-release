//
//  RoomState.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//


#import "WhiteDisplayerState.h"
#import "WhiteMemberState.h"
#import "WhiteBroadcastState.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteRoomState : WhiteDisplayerState

/** 当前用户的教具状态 */
@property (nonatomic, strong, readonly) WhiteReadonlyMemberState *memberState;

/** 视野信息 */
@property (nonatomic, strong, readonly) WhiteBroadcastState *broadcastState;

/** 缩放比例 */
@property (nonatomic, strong, nullable, readonly) NSNumber *zoomScale;

@end

NS_ASSUME_NONNULL_END
