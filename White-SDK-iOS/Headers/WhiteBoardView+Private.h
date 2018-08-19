//
//  WhiteBoardView+Private.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import <WhiteSDK/WhiteSDK.h>
#import "WhiteRoom.h"
#import "WhiteRoomCallbacks.h"

@interface WhiteBoardView ()

- (void)bindRoom:(WhiteRoom *)room callbacks:(id<WhiteRoomCallbackDelegate>)callbacks;

@end
