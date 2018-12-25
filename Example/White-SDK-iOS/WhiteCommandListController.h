//
//  WhiteCommandTableViewController.h
//  WhiteSDKPrivate_Example
//
//  Created by yleaf on 2018/12/24.
//  Copyright © 2018 leavesster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WhiteSDK.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *WhiteCommandCustomEvent = @"WhiteCommandCustomEvent";

@interface WhiteCommandListController : UITableViewController

- (instancetype)initWithRoom:(WhiteRoom *)room;

@end

NS_ASSUME_NONNULL_END
