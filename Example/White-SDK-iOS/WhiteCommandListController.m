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
    CommandTypePpt,
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
    
    self.commands = @[NSLocalizedString(@"主播", nil), NSLocalizedString(@"观众", nil), NSLocalizedString(@"发送自定义事件", nil), NSLocalizedString(@"插入 PPT", nil), NSLocalizedString(@"只读", nil), NSLocalizedString(@"取消只读", nil), NSLocalizedString(@"画笔", nil), NSLocalizedString(@"矩形", nil)];
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
        case CommandTypePpt:
        {
            WhitePptPage *pptPage = [[WhitePptPage alloc] init];
            pptPage.src = @"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/alin-rusu-1239275-unsplash_opt.jpg";
            pptPage.width = 400;
            pptPage.height = 600;
            //WhiteGlobalState PPT插入后，White SDK 会创建多个新页面（默认仍然停留在当前页）
            //插入后，会触发 WhiteRoomCallbackDelegate 回调。
            //可以参考 whiteRoomViewController 中 - (void)fireRoomStateChanged:(WhiteRoomState *)magixPhase; 回调处理。
            [self.room pushPptPages:@[pptPage]];
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
}

@end
