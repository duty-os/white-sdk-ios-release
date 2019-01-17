//
//  RoomState.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//


#import "WhiteObject.h"
#import "WhiteGlobalState.h"
#import "WhiteMemberState.h"
#import "WhiteRoomMember.h"
#import "WhiteBroadcastState.h"
#import "WhiteLinearTransformationDescription.h"

@interface WhiteRoomState : WhiteObject

@property (nonatomic, strong, nullable) WhiteGlobalState *globalState;
@property (nonatomic, strong, nullable) WhiteMemberState *memberState;
@property (nonatomic, strong, nullable) NSArray<WhiteRoomMember *> *WhiteRoomMembers;
@property (nonatomic, strong, nullable) NSArray<NSString *> *pptImages;
@property (nonatomic, strong, nullable) WhiteBroadcastState *broadcastState;
@property (nonatomic, strong, nullable) WhiteLinearTransformationDescription *transform;
@end
