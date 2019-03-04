//
//  WhitePlayerConsts.h
//  WhiteSDK
//
//  Created by yleaf on 2019/3/3.
//

#ifndef WhitePlayerConsts_h
#define WhitePlayerConsts_h

typedef NS_ENUM(NSInteger, WhiteObserverMode) {
    WhiteObserverModeDirectory,
    WhiteObserverModeFreedom
};

typedef NS_ENUM(NSInteger, WhitePlayerPhase) {
    WhitePlayerPhaseWaitingFirstFrame,
    WhitePlayerPhasePlaying,
    WhitePlayerPhasePause,
    WhitePlayerPhaseStopped,
    WhitePlayerPhaseEnded,
    WhitePlayerPhaseBuffering,
};

#endif /* WhitePlayerConsts_h */
