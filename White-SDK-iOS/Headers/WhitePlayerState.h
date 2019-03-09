//
//  WhitePlayerState.h
//  WhiteSDK
//
//  Created by yleaf on 2019/2/28.
//

#import "WhiteObject.h"
#import "WhiteGlobalState.h"
#import "WhiteObserverState.h"
#import "WhiteRoomMember.h"
#import "WhiteSceneState.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhitePlayerState : WhiteObject

@property (nonatomic, strong, readonly, nullable) WhiteGlobalState *globalState;
/** 房间用户状态 */
@property (nonatomic, strong, readonly, nullable) NSArray<WhiteRoomMember *> *roomMembers;
/** 用户观察状态 */
@property (nonatomic, strong, readonly, nullable) WhiteObserverState *observerState;
/** 场景状态 */
@property (nonatomic, strong, readonly, nullable) WhiteSceneState *sceneState;

@end

NS_ASSUME_NONNULL_END
