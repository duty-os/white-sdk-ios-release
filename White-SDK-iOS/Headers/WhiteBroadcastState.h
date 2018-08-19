//
//  BroadcastState.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"
#import "WhiteMemberInformation.h"

typedef NS_ENUM(NSInteger, WhiteViewMode) {
    WhiteViewModeFreedom,
    WhiteViewModeFollower,
    WhiteViewModeBroadcaster,
};

@interface WhiteBroadcastState : WhiteObject
@property (nonatomic, assign) WhiteViewMode viewMode;
@property (nonatomic, assign) NSInteger broadcasterId;
@property (nonatomic, strong) WhiteMemberInformation *broadcasterInformation;
@end
