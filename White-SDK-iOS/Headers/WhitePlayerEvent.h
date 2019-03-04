//
//  WhitePlayerEvent.h
//  WhiteSDK
//
//  Created by yleaf on 2019/3/1.
//

#import <Foundation/Foundation.h>
#import "WhiteObserverState.h"
#import "WhitePlayerState.h"
#import "WhitePlayerConsts.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WhitePlayerEventDelegate <NSObject>

- (void)phaseChanged:(WhitePlayerPhase)phase;
- (void)loadFirstFrame;
- (void)sliceChanged:(NSString *)slice;
- (void)playerStateChanged:(WhitePlayerState *)modifyState;
- (void)stoppedWithError:(NSError *)error;
- (void)scheduleTimeChanged:(NSInteger)time;

@end

@interface WhitePlayerEvent : NSObject

@property (nonatomic, weak) id<WhitePlayerEventDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
