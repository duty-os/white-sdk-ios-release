//
//  WhitePlayerViewController.h
//  WhiteSDKPrivate_Example
//
//  Created by yleaf on 2019/3/2.
//  Copyright © 2019 leavesster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhiteBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^PlayBlock)(WhitePlayer *room, NSError *eroror);

@interface WhitePlayerViewController : UIViewController
@property (nonatomic, copy) NSString *roomUuid;

#pragma mark - Unit Testing
@property (nonatomic, copy) PlayBlock playBlock;

#pragma mark - CallbackDelegate
@property (nonatomic, weak) id<WhiteCommonCallbackDelegate> commonDelegate;
@property (nonatomic, weak) id<WhitePlayerEventDelegate> eventDelegate;

@end

NS_ASSUME_NONNULL_END
