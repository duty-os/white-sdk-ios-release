//
//  WhiteViewController.h
//  WhiteSDK
//
//  Created by leavesster on 08/12/2018.
//  Copyright (c) 2018 leavesster. All rights reserved.
//

@import UIKit;
#import "WhiteSDK.h"

typedef void(^RoomBlock)(WhiteRoom *room);

@interface WhiteRoomViewController : UIViewController

@property (nonatomic, copy) NSString *roomUuid;

@property (nonatomic, strong) WhiteRoom *room;

#pragma mark - Unit Testing
@property (nonatomic, weak) id<WhiteRoomCallbackDelegate> roomCallback;
@property (nonatomic, copy) RoomBlock roomBlock;

@end
