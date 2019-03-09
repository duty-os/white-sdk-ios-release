//
//  WhiteViewController.h
//  WhiteSDK
//
//  Created by leavesster on 08/12/2018.
//  Copyright (c) 2018 leavesster. All rights reserved.
//

@import UIKit;
#import "WhiteBaseViewController.h"

typedef void(^RoomBlock)(WhiteRoom * _Nullable room, NSError * _Nullable eroror);

@interface WhiteRoomViewController : WhiteBaseViewController

@property (nonatomic, strong, nullable) WhiteRoom *room;

#pragma mark - Unit Testing
@property (nonatomic, copy, nullable) RoomBlock roomBlock;

#pragma mark - CallbackDelegate
@property (nonatomic, weak, nullable) id<WhiteRoomCallbackDelegate> roomCallbackDelegate;

@end
