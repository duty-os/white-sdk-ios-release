//
//  StartController.m
//  white-demo-ios
//
//  Created by leavesster on 2018/8/19.
//  Copyright © 2018年 yleaf. All rights reserved.
//

#import "WhiteStartViewController.h"
#import "WhiteRoomViewController.h"

@interface WhiteStartViewController ()
@property (nonatomic, strong) UITextField *inputV;
@end

@implementation WhiteStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFillProportionally;
    stackView.alignment = UIStackViewAlignmentCenter;
    [self.view addSubview:stackView];
    
    stackView.frame = CGRectMake(0, 0, 300, 120);
    stackView.center = self.view.center;
    stackView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    UITextField *field = [[UITextField alloc] init];
    field.enabled = YES;
    field.placeholder = NSLocalizedString(@"输入房间ID，加入房间", nil);
    [stackView addArrangedSubview:field];
    self.inputV = field;
    
    UIButton *joinBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [joinBtn setTitle:NSLocalizedString(@"加入房间", nil) forState:UIControlStateNormal];
    [joinBtn addTarget:self action:@selector(joinRoom:) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:joinBtn];
    
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [createBtn setTitle:NSLocalizedString(@"创建新房间", nil) forState:UIControlStateNormal];
    [createBtn addTarget:self action:@selector(createRoom:) forControlEvents:UIControlEventTouchUpInside];
    [stackView addArrangedSubview:createBtn];
    
    for (UIView *view in stackView.arrangedSubviews) {
        [view setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [view setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeybroader:)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeybroader:(id)sender
{
    [self.inputV resignFirstResponder];
}

#pragma mark - Button Action
- (void)joinRoom:(UIButton *)sender
{
    WhiteRoomViewController *vc = [[WhiteRoomViewController alloc] init];
    vc.roomUuid = self.inputV.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)createRoom:(UIButton *)sender
{
    WhiteRoomViewController *vc = [[WhiteRoomViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
