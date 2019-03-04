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

NS_ASSUME_NONNULL_BEGIN

@interface WhitePlayerState : WhiteObject

@property (nonatomic, strong, readonly, nullable) WhiteGlobalState *globalState;
@property (nonatomic, strong, readonly, nullable) NSArray<WhiteRoomMember *> *roomMembers;
@property (nonatomic, strong, readonly, nullable) WhitePlayerState *observerState;

@end

NS_ASSUME_NONNULL_END
