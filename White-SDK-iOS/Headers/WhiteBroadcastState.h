//
//  BroadcastState.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"
#import "WhiteMemberInformation.h"

typedef NS_ENUM(NSInteger, WhiteViewMode) {
    // 自由模式
    // 用户可以自由放缩、移动视角。
    // 即便房间里有主播，主播也无法影响用户的视角。
    WhiteViewModeFreedom,
    // 追随模式
    // 用户将追随主播的视角。主播在看哪里，用户就会跟着看哪里。
    // 在这种模式中，如果用户进行缩放、移动视角操作，将自动切回 freedom模式。
    WhiteViewModeFollower,
    // 主播模式
    // 房间内其他人的视角模式会被自动修改成 follower，并且强制观看该用户的视角。
    // 如果房间内存在另一个主播，该主播的视角模式也会被强制改成 follower。
    WhiteViewModeBroadcaster,
};

@interface WhiteBroadcasterInformation : WhiteObject
/** 该用户在白板中的数字 */
@property (nonatomic, assign, readonly) NSNumber *id;
/** 该用户在加入白板时，带入的用户信息 */
@property (nonatomic, assign, readonly) id payload;

@end

@interface WhiteBroadcastState : WhiteObject

@property (nonatomic, assign, readonly) WhiteViewMode viewMode;
@property (nonatomic, assign, readonly) NSInteger broadcasterId;
@property (nonatomic, strong, readonly) WhiteBroadcasterInformation *broadcasterInformation;

@end
