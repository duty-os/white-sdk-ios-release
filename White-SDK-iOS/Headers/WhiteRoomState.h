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

@property (nonatomic, strong) WhiteGlobalState *globalState;
@property (nonatomic, strong) WhiteMemberState *memberState;
@property (nonatomic, strong) NSArray<WhiteRoomMember *> *WhiteRoomMembers;
@property (nonatomic, strong) NSArray<NSString *> *pptImages;
@property (nonatomic, strong) WhiteBroadcastState *broadcastState;
@property (nonatomic, strong) WhiteLinearTransformationDescription *transform;
@end
