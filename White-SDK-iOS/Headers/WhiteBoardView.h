//
//  WhiteBroadView.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import <dsbridge/dsbridge.h>
#import "WhiteRoom.h"

@interface WhiteBoardView : DWKWebView

@property (nonatomic, strong, nullable) WhiteRoom *room;

- (instancetype)init;

@end
