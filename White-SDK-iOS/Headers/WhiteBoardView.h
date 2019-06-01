//
//  WhiteBroadView.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import <dsbridge/dsbridge.h>
#import "WhiteRoom.h"
#import "WhitePlayer.h"

NS_ASSUME_NONNULL_BEGIN


@interface WhiteBoardView : DWKWebView

@property (nonatomic, strong, nullable) WhiteRoom *room;
@property (nonatomic, strong, nullable) WhitePlayer *player;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
