//
//  RoomState.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//


#import "WhiteObject.h"
#import "WhiteGlobalState.h"
#import "WhiteMemberState.h"
#import "WhiteSceneState.h"
#import "WhiteRoomMember.h"
#import "WhiteBroadcastState.h"

@interface WhiteRoomState : WhiteObject

@property (nonatomic, strong, nullable, readonly) WhiteGlobalState *globalState;
@property (nonatomic, strong, nullable, readonly) WhiteMemberState *memberState;
@property (nonatomic, strong, nullable, readonly) WhiteSceneState *sceneState;
@property (nonatomic, strong, nullable, readonly) NSArray<WhiteRoomMember *> *roomMembers;
@property (nonatomic, strong, nullable, readonly) WhiteBroadcastState *broadcastState;
@property (nonatomic, strong, nullable, readonly) NSNumber *zoomScale;

@end
