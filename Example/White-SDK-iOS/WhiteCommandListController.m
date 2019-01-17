//
//  WhiteCommandTableViewController.m
//  WhiteSDKPrivate_Example
//
//  Created by yleaf on 2018/12/24.
//  Copyright © 2018 leavesster. All rights reserved.
//

#import "WhiteCommandListController.h"

typedef NS_ENUM(NSInteger, CommandType) {
    CommandTypeBroadercast,
    CommandTypeFollower,
    CommandTypeCustomEvent,
    CommandTypeInsertPpt,
    CommandTypeInsertImage,
    CommandTypeGetPpt,
    CommandTypeGetScene,
    CommandTypeGetRoomPhase,
    CommandTypeReadonly,
    CommandTypeEnable,
    CommandTypePencil,
    CommandTypeRectangle,
};

@interface WhiteCommandListController ()

@property (nonatomic, strong) NSArray<NSString *> *commands;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, assign, getter=isReadonly) BOOL readonly;

@end

@implementation WhiteCommandListController

static NSString *kReuseCell = @"reuseCell";

- (instancetype)initWithRoom:(WhiteRoom *)room
{
    if (self = [super init]) {
        _room = room;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commands = @[NSLocalizedString(@"主播", nil), NSLocalizedString(@"观众", nil), NSLocalizedString(@"发送自定义事件", nil), NSLocalizedString(@"插入 PPT", nil), NSLocalizedString(@"插入图片", nil), NSLocalizedString(@"获取PPT", nil), NSLocalizedString(@"获取页面数据", nil), NSLocalizedString(@"获取连接状态", nil), NSLocalizedString(@"只读", nil), NSLocalizedString(@"取消只读", nil), NSLocalizedString(@"画笔", nil), NSLocalizedString(@"矩形", nil)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseCell];
}

- (CGSize)preferredContentSize
{
    return CGSizeMake(150, self.commands.count * 44);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.commands count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseCell forIndexPath:indexPath];
    
    cell.textLabel.text = self.commands[indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case CommandTypeBroadercast:
            [self.room setViewMode:WhiteViewModeBroadcaster];
            break;
        case CommandTypeFollower:
            [self.room setViewMode:WhiteViewModeFollower];
            break;
        case CommandTypeCustomEvent:
            [self.room dispatchMagixEvent:WhiteCommandCustomEvent payload:@{WhiteCommandCustomEvent: @"test"}];
            break;
        case CommandTypeInsertPpt:
        {
            WhitePptPage *pptPage = [[WhitePptPage alloc] init];
            pptPage.src = @"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/alin-rusu-1239275-unsplash_opt.jpg";
            pptPage.width = 400;
            pptPage.height = 600;
            
            //WhiteGlobalState PPT插入后，White SDK 会创建多个新页面（默认仍然停留在当前页）
            [self.room pushPptPages:@[pptPage]];
            
            [self.room getPptImagesWithResult:^(NSArray<NSString *> *pptPages) {
                WhiteGlobalState *state = [[WhiteGlobalState alloc] init];
                state.currentSceneIndex = [pptPages count] - 1;
                //主动调用者，自行切换页面。由于页面信息是全局状态，会立即同步给所有人
                //其他人会在 WhiteRoomCallbackDelegate 回调中收到改动通知
                [self.room setGlobalState:state];
            }];
            break;
        }
        case CommandTypeInsertImage:
        {
            WhiteImageInformation *info = [[WhiteImageInformation alloc] init];
            info.width = 200;
            info.height = 300;
            info.uuid = @"WhiteImageInformation";
            [self.room insertImage:info];
            [self.room completeImageUploadWithUuid:info.uuid src:@"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/alin-rusu-1239275-unsplash_opt.jpg"];
            break;
        }
        case CommandTypeGetPpt:
        {
            [self.room getPptImagesWithResult:^(NSArray<NSString *> *pptPages) {
                NSLog(@"pptImage:%@", pptPages);
            }];
            break;
        }
        case CommandTypeGetScene:
        {
            [self.room getScenesWithResult:^(NSArray<WhiteScene *> *scenes) {
                NSLog(@"scenes:%@", scenes);
            }];
            break;
        }
        case CommandTypeGetRoomPhase:
        {
            [self.room getRoomPhaseWithResult:^(WhiteRoomPhase phase) {
                NSLog(@"WhiteRoomPhase:%ld", (long)phase);
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"当前连接状态", nil) message:[NSString stringWithFormat:NSLocalizedString(@"WhiteRoomPhase:%ld", nil), (long)phase] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:action];
                [self presentViewController:alertController animated:YES completion:nil];
            }];
            break;
        }
        case CommandTypeReadonly:
        {
            [self.room disableOperations:YES];
        }
            break;
        case CommandTypeEnable:
        {
            [self.room disableOperations:NO];
        }
            break;
        case CommandTypePencil:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = AppliancePencil;
            [self.room setMemberState:mState];
        }
            break;
        case CommandTypeRectangle:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = ApplianceRectangle;
            [self.room setMemberState:mState];
        }
            break;
        default:
            break;
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
