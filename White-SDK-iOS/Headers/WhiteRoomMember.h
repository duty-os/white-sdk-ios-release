//
//  WhiteRoomMember.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"
#import "WhiteMemberInformation.h"

@interface WhiteRoomMember : WhiteObject

@property (nonatomic, copy, readonly) NSString *currentApplianceName;
/** 进入在该房间中时的序号 */
@property (nonatomic, assign, readonly) NSInteger memberId;

/**
 兼容旧版本， 从 iOS 2.1.0（Android 2.0.0，web 2.0.0）开始，使用 payload 字段
 */
@property (nonatomic, strong, readonly) WhiteMemberInformation *information;

/**
 从 iOS 2.1.0（Android 2.0.0，web 2.0.0） 开始，加入房间时，允许带入任意数据（限制：允许转换为 JSON，或者单纯的字符串，数字）
 如果想要使用 SDK 默认头像显示，请全平台使用 avatar 字段设置用户头像。
 */
@property (nonatomic, strong, readonly) id payload;

@end
