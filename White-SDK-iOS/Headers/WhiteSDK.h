//
//  WhiteSDK.h
//  Pods-white-ios-sdk_Example
//
//  Created by leavesster on 2018/8/11.
//

#import <Foundation/Foundation.h>
#import "WhiteRoom.h"
#import "WhiteRoomCallbacks.h"
#import "WhiteBoardView.h"
#import "WhiteSdkConfiguration.h"

@interface WhiteSDK : NSObject

- (instancetype)initWithWhiteBoardView:(WhiteBoardView *)whiteBoardView config:(WhiteSdkConfiguration *)config;
- (void)joinRoomWithRoomUuid:(NSString *)roomUuid roomToken:(NSString *)roomToken callbacks:(id<WhiteRoomCallbackDelegate>)callbacks completionHandler:(void (^) (BOOL success, WhiteRoom *room, NSError *error))completionHander;

@end
