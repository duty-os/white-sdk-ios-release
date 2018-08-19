//
//  WhiteBroadView.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import <dsBridge/dsBridge.h>
#import "WhiteRoom.h"

@interface WhiteBoardView : DWKWebView

@property (nonatomic, strong) WhiteRoom *room;

- (instancetype)init;

@end
