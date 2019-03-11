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

@property (nonatomic, strong, nullable, readonly) WhiteGlobalState *globalState;
@property (nonatomic, strong, nullable, readonly) WhiteMemberState *memberState;
@property (nonatomic, strong, nullable, readonly) NSArray<WhiteRoomMember *> *WhiteRoomMembers;
@property (nonatomic, strong, nullable, readonly) NSArray<NSString *> *pptImages;
@property (nonatomic, strong, nullable, readonly) WhiteBroadcastState *broadcastState;
@property (nonatomic, strong, nullable, readonly) WhiteLinearTransformationDescription *transform;

@end
