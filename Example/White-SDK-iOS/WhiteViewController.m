//
//  WhiteViewController.m
//  WhiteSDK
//
//  Created by leavesster on 08/12/2018.
//  Copyright (c) 2018 leavesster. All rights reserved.
//

#import "WhiteViewController.h"
#import <White-SDK-iOS/WhiteSDK.h>

@interface WhiteViewController ()
@property (nonatomic, copy) NSString *sdkToken;
@property (nonatomic, strong) WhiteRoom *room;
@property (nonatomic, strong) WhiteSDK *sdk;
@property (nonatomic, strong) WhiteBoardView *boardView;
@end

@implementation WhiteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sdkToken = @"WHITEcGFydG5lcl9pZD1QNnR4cXJEQlZrZmJNZWRUdGVLenBURXRnZzhjbGZ6ZnZteUQmc2lnPWYzZjlkOTdhYTBmZmVhZTUxYzAxYTk0N2QwMWZmMzQ5ZGRhYjhmMmQ6YWRtaW5JZD0xJnJvbGU9YWRtaW4mZXhwaXJlX3RpbWU9MTU0OTYyNzcyMyZhaz1QNnR4cXJEQlZrZmJNZWRUdGVLenBURXRnZzhjbGZ6ZnZteUQmY3JlYXRlX3RpbWU9MTUxODA3MDc3MSZub25jZT0xNTE4MDcwNzcxMjg3MDA";
    [self createRoomWithResult:^(BOOL success, id response) {
        NSString *roomToken = [[response valueForKey:@"msg"]valueForKey:@"roomToken"];
        NSString *uuid =[[[response valueForKey:@"msg"]valueForKey:@"room"]valueForKey:@"uuid"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.boardView = [[WhiteBoardView alloc] init];
            self.sdk = [[WhiteSDK alloc] initWithWhiteBoardView:self.boardView config:[WhiteSdkConfiguration defaultConfig]];
            [self.sdk joinRoomWithRoomUuid:uuid roomToken:roomToken callbacks:(id<WhiteRoomCallbackDelegate>)self completionHandler:^(BOOL success, WhiteRoom *room, NSError *error) {
                if (success) {
                    self.room = room;
                    self.boardView.frame = self.view.bounds;
                    self.boardView.autoresizingMask = UIViewAutoresizingFlexibleWidth |  UIViewAutoresizingFlexibleHeight;
                    [self.view addSubview:self.boardView];
                } else {
                    //TODO: error
                }
            }];
        });
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self setTestingAPI];
}

#pragma mark - Set API
- (void)setTestingAPI
{
    [self.room setViewMode:WhiteViewModeBroadcaster];
    //    [self.room setViewSizeWithWidth:300 height:600];
    
    WhiteMemberState *mState = [[WhiteMemberState alloc] init];
    mState.currentApplianceName = ApplianceRectangle;
    [self.room setMemberState:mState];
    
    WhitePptPage *pptPage = [[WhitePptPage alloc] init];
    pptPage.src = @"https://white-pan.oss-cn-shanghai.aliyuncs.com/101/image/image.png";
    pptPage.width = 600;
    pptPage.height = 600;
    [self.room pushPptPages:@[pptPage]];
    
    //    WhiteTextareaBox *textBox = [[WhiteTextareaBox alloc] init];
    //    textBox.width = 200;
    //    textBox.height = 200;
    //    textBox.originalText = @"这是一个测试文本";
    //    WhiteTextareaLine *line = [[WhiteTextareaLine alloc] init];
    //    line.dx = 0;
    //    line.dy = 0;
    //    line.string = @"这是一个测试文本";
    //    line.textLength = [@"这是一个测试文本" length];
    //    textBox.textareaLine = @[line];
    //    [self.room updateTextarea:textBox];
}

#pragma mark - Get API
- (void)getTestingAPI
{
    [self.room getPptImagesWithResult:^(NSArray<NSString *> *pptPages) {
        NSLog(@"%@", pptPages);
        
    }];
    
    [self.room getTransformWithResult:^(WhiteLinearTransformationDescription *transform) {
        NSLog(@"%@", [transform jsonString]);
    }];
    
    [self.room getGlobalStateWithResult:^(WhiteGlobalState *state) {
        NSLog(@"%@", [state jsonString]);
    }];
    
    [self.room getMemberStateWithResult:^(WhiteMemberState *state) {
        NSLog(@"%@", [state jsonString]);
    }];
    
    [self.room getBroadcastStateWithResult:^(WhiteBroadcastState *state) {
        NSLog(@"%@", [state jsonString]);
    }];
    
    [self.room getRoomMembersWithResult:^(NSArray<WhiteRoomMember *> *roomMembers) {
        for (WhiteRoomMember *m in roomMembers) {
            NSLog(@"%@", [m jsonString]);
        }
    }];
}


#pragma mark - WhiteRoomCallbackDelegate
- (void)firePhaseChanged:(WhiteRoomPhase)phase
{
    NSLog(@"%s, %ld", __FUNCTION__, (long)phase);
}

- (void)fireRoomStateChanged:(WhiteRoomState *)magixPhase;
{
    NSLog(@"%s, %@", __func__, [magixPhase jsonString]);
    if ([magixPhase.pptImages count] > 0) {
        //传入ppt时，立刻跳到对应页
        WhiteGlobalState *state = [[WhiteGlobalState alloc] init];
        state.currentSceneIndex = [magixPhase.pptImages count] - 1;
        [self.room setGlobalState:state];
    }
}

- (void)fireBeingAbleToCommitChange:(BOOL)isAbleToCommit
{
    NSLog(@"%s, %d", __func__, isAbleToCommit);
    
}

- (void)fireDisconnectWithError:(NSString *)error
{
    NSLog(@"%s, %@", __func__, error);
    
}

- (void)fireKickedWithReason:(NSString *)reason
{
    NSLog(@"%s, %@", __func__, reason);
}

- (void)fireCatchErrorWhenAppendFrame:(NSUInteger)userId error:(NSString *)error
{
    NSLog(@"%s, %luu %@", __func__,(unsigned long) (unsigned long)userId, error);
}


#pragma mark - CreateRoom
- (void)createRoomWithResult:(void (^) (BOOL success, id response))result;
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://cloudcapiv3.herewhite.com/room?token=%@", self.sdkToken]]];
    NSMutableURLRequest *modifyRequest = [request mutableCopy];
    [modifyRequest setHTTPMethod:@"POST"];
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [modifyRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSDictionary *params = @{@"name": @"test", @"limit": @110, @"width": @1024, @"height": @768, @"mode": @"persistent"};
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    [modifyRequest setHTTPBody:postData];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:modifyRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error && result) {
            result(NO, nil);
        } else if (result) {
            NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            result(YES, responseObject);
        }
    }];
    [task resume];
}


@end
