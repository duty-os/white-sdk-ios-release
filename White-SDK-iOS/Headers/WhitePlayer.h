//
//  WhitePlayer.h
//  WhiteSDK
//
//  Created by yleaf on 2019/2/28.
//

#import <Foundation/Foundation.h>
#import "WhitePlayerConsts.h"
#import "WhitePlayerState.h"
#import "WhiteObserverState.h"
#import "WhitePlayerTimeInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhitePlayer : NSObject

@property (nonatomic, copy, readonly) NSString *uuid;

#pragma mark - action API

- (void)play;
- (void)pause;
- (void)stop;
- (void)seekToScheduleTime:(NSInteger)beginTime;
- (void)setObserMode:(WhiteObserverMode)mode;
- (void)setFollowUserId:(NSInteger)userId;

#pragma mark - get API

- (void)getPhaseWithResult:(void (^)(WhitePlayerPhase phase))result;
- (void)getPlayerStateWithResult:(void (^) (WhitePlayerState *state))result;
- (void)getPlayerTimeInfoWithResult:(void (^) (WhitePlayerTimeInfo *info))result;

@end

NS_ASSUME_NONNULL_END
