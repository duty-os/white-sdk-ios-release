//
//  WhiteViewController.h
//  WhiteSDK
//
//  Created by leavesster on 08/12/2018.
//  Copyright (c) 2018 leavesster. All rights reserved.
//

@import UIKit;
#import "WhiteBaseViewController.h"

typedef void(^RoomBlock)(WhiteRoom *room, NSError *eroror);

@interface WhiteRoomViewController : WhiteBaseViewController

@property (nonatomic, strong) WhiteRoom *room;

#pragma mark - Unit Testing
@property (nonatomic, copy) RoomBlock roomBlock;

#pragma mark - CallbackDelegate
@property (nonatomic, weak) id<WhiteRoomCallbackDelegate> roomCallbackDelegate;

@end
