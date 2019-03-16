//
//  WhiteBaseViewController.m
//  WhiteSDKPrivate_Example
//
//  Created by yleaf on 2019/3/4.
//  Copyright © 2019 leavesster. All rights reserved.
//

#import "WhiteBaseViewController.h"
#import <Masonry/Masonry.h>

@interface WhiteBaseViewController ()<WhiteCommonCallbackDelegate>

@end

@implementation WhiteBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews
{
    #warning WhiteboardView 初始化注意事项：
    /**
     请提前将 WhiteBoardView 添加至视图栈中（生成 whiteSDK 前）。否则 iOS 12 真机无法执行正常执行sdk代码。
     */
    self.boardView = [[WhiteBoardView alloc] init];
    [self.view addSubview:self.boardView];
    /*
     需要手动兼容 iOS10 及其以下。
     FIX UIScrollView 自动偏移的问题
     WhiteBoardView 内部有 UIScrollView，在 iOS 10及其以下时，如果 WhiteBoardView 是当前视图栈中第一个的话，会出现内容错位。
     iOS 11 及其以上已做处理。
     */
    if (@available(iOS 11, *)) {
    } else {
        //可以参考此处处理。
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.boardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark -
- (void)showPopoverViewController:(UIViewController *)vc sourceView:(id)sourceView
{
    vc.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *present = vc.popoverPresentationController;
    present.permittedArrowDirections = UIPopoverArrowDirectionAny;
    present.delegate = (id<UIPopoverPresentationControllerDelegate>)self;
    if ([sourceView isKindOfClass:[UIView class]]) {
        present.sourceView = sourceView;
        present.sourceRect = [sourceView bounds];
    } else if ([sourceView isKindOfClass:[UIBarButtonItem class]]) {
        present.barButtonItem = sourceView;
    } else {
        present.sourceView = self.view;
    }
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    return YES;
}


#pragma mark - CallbackDelegate
- (id<WhiteCommonCallbackDelegate>)commonDelegate
{
    if (!_commonDelegate) {
        _commonDelegate = self;
    }
    return _commonDelegate;
}


@end
