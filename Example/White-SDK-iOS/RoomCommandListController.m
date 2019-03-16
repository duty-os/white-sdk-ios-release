//
//  WhiteCommandTableViewController.m
//  WhiteSDKPrivate_Example
//
//  Created by yleaf on 2018/12/24.
//  Copyright © 2018 leavesster. All rights reserved.
//

#import "RoomCommandListController.h"

typedef NS_ENUM(NSInteger, CommandType) {
    CommandTypeBroadercast,
    CommandTypeFollower,
    CommandTypeCurrentViewMode,
    CommandTypeCustomEvent,
    CommandTypeCleanScene,
    CommandTypeInsertNewScene,
    CommandTypeInsertPpt,
    CommandTypeInsertImage,
    CommandTypeGetPpt,
    CommandTypeGetScene,
    CommandTypeGetRoomPhase,
    CommandTypeDisconnect,
    CommandTypeReadonly,
    CommandTypeEnable,
    CommandTypePencil,
    CommandTypeRectangle,
    CommandTypeColor,
    CommandTypeCustomDevice,
};

@interface RoomCommandListController ()

@property (nonatomic, strong) NSArray<NSString *> *commands;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, assign, getter=isReadonly) BOOL readonly;

@end

@implementation RoomCommandListController

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

    self.commands = @[NSLocalizedString(@"主播", nil), NSLocalizedString(@"观众", nil),  NSLocalizedString(@"当前视角状态", nil), NSLocalizedString(@"发送自定义事件", nil), NSLocalizedString(@"清屏", nil), NSLocalizedString(@"插入新页面", nil), NSLocalizedString(@"插入 PPT", nil), NSLocalizedString(@"插入图片", nil), NSLocalizedString(@"获取PPT", nil), NSLocalizedString(@"获取页面数据", nil), NSLocalizedString(@"获取连接状态", nil), NSLocalizedString(@"主动断连", nil), NSLocalizedString(@"只读", nil), NSLocalizedString(@"取消只读", nil), NSLocalizedString(@"画笔", nil), NSLocalizedString(@"矩形", nil), NSLocalizedString(@"颜色", nil), NSLocalizedString(@"外部设备输入", nil)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseCell];
}

- (CGSize)preferredContentSize
{
    return CGSizeMake(150, MIN(self.commands.count, 6) * 44);
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
        case CommandTypeCurrentViewMode:
        {
            [self.room getBroadcastStateWithResult:^(WhiteBroadcastState *state) {
                NSLog(@"broadcastState:%@", [state jsonString]);
            }];
            break;
        }
        case CommandTypeCustomEvent:
            [self.room dispatchMagixEvent:WhiteCommandCustomEvent payload:@{WhiteCommandCustomEvent: @"test"}];
            break;
        case CommandTypeCleanScene:
            [self.room cleanScene:YES];
            break;
        case CommandTypeInsertNewScene:
        case CommandTypeInsertPpt:
        {
            //v2.0 新 API
            WhitePptPage *pptPage = [[WhitePptPage alloc] init];
            pptPage.src = @"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/alin-rusu-1239275-unsplash_opt.jpg";
            pptPage.width = 400;
            pptPage.height = 600;
            WhiteScene *scene = [[WhiteScene alloc] initWithName:@"opt" ppt:pptPage];
            
            //插入新页面的 API，现在支持传入 ppt 参数（可选），所以插入PPT和插入新页面的 API，合并成了一个。
            [self.room putScenes:@"/ppt" scenes:@[scene] index:0];
            [self.room setScenePath:@"/ppt/opt"];
            break;
        }
        case CommandTypeInsertImage:
        {
            WhiteImageInformation *info = [[WhiteImageInformation alloc] init];
            info.width = 200;
            info.height = 300;
            info.uuid = @"WhiteImageInformation";
            //这一行与注释的两行代码等效
            [self.room insertImage:info src:@"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/alin-rusu-1239275-unsplash_opt.jpg"];
//            [self.room insertImage:info];
//            [self.room completeImageUploadWithUuid:info.uuid src:@"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/alin-rusu-1239275-unsplash_opt.jpg"];
            break;
        }
        case CommandTypeGetPpt:
        {
            //v2.0 新API，通过获取每个 scene，再去查询 ppt 属性，如果没有 ppt，则 ppt 属性会为空
            [self.room getScenesWithResult:^(NSArray<WhiteScene *> * _Nonnull scenes) {
                for (WhiteScene *s in scenes) {
                    NSLog(@"ppt:%@", s.ppt.src);
                }
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
                [self.presentingViewController presentViewController:alertController animated:YES completion:nil];
            }];
            break;
        }
        case CommandTypeDisconnect:
        {
            [self.room disconnect:^{
                
            }];
            break;
        }
        case CommandTypeReadonly:
            [self.room disableOperations:YES];
            break;
        case CommandTypeEnable:
            [self.room disableOperations:NO];
            break;
        case CommandTypePencil:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = AppliancePencil;
            [self.room setMemberState:mState];
            break;
        }
        case CommandTypeRectangle:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = ApplianceRectangle;
            [self.room setMemberState:mState];
            break;
        }
        case CommandTypeColor:
        {
            WhiteMemberState *mState = [[WhiteMemberState alloc] init];
            mState.currentApplianceName = AppliancePencil;
            mState.strokeColor = @[@200, @200, @200];
            mState.strokeWidth = @10;
            [self.room setMemberState:mState];
            break;
        }
        case CommandTypeCustomDevice:
        {
            [self.room disableOperations:YES];
            WhitePanEvent *panEvent = [[WhitePanEvent alloc] init];
            panEvent.x = 100;
            panEvent.y = 100;
            [self.room externalDeviceEventDown:panEvent];
            
            int i = 0;
            while (i < 20) {
                panEvent.x = 100 + i * 3;
                panEvent.y = 100 + i * 3;
                [self.room externalDeviceEventMove:panEvent];
                i++;
            }
            [self.room externalDeviceEventUp:panEvent];
            [self.room disableOperations:NO];
            break;
        }
        default:
            break;
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
