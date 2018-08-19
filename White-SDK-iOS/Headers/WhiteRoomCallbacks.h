//
//  WhiteNativeApi.h
//  Pods
//
//  Created by leavesster on 2018/8/12.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WhiteRoomPhase) {
    WhiteRoomPhaseReady,
    WhiteRoomPhaseConnecting,
    WhiteRoomPhaseConnected,
    WhiteRoomPhaseReconnecting,
    WhiteRoomPhaseDisconnecting,
    WhiteRoomPhaseClosed,
};

@class WhiteRoomState;

@protocol WhiteRoomCallbackDelegate <NSObject>
- (void)firePhaseChanged:(WhiteRoomPhase)phase;
- (void)fireRoomStateChanged:(WhiteRoomState *)magixPhase;
- (void)fireBeingAbleToCommitChange:(BOOL)isAbleToCommit;
- (void)fireDisconnectWithError:(NSString *)error;
- (void)fireKickedWithReason:(NSString *)reason;
- (void)fireCatchErrorWhenAppendFrame:(NSUInteger)userId error:(NSString *)error;

@end

@interface WhiteRoomCallbacks : NSObject

@property (nonatomic, weak) id<WhiteRoomCallbackDelegate> delegate;

@end
