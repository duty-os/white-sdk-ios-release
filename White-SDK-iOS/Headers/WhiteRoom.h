//
//  WhiteRoom.h
//  dsBridge
//
//  Created by leavesster on 2018/8/11.
//

#import <Foundation/Foundation.h>
#import "WhiteGlobalState.h"
#import "WhiteMemberState.h"
#import "WhiteTextareaBox.h"
#import "WhiteImageInformation.h"
#import "WhitePptPage.h"
#import "WhiteRoomMember.h"
#import "WhiteLinearTransformationDescription.h"
#import "WhiteBroadcastState.h"
#import "WhiteRoomCallbacks.h"
#import "WhiteRoomState.h"

@class WhiteBoardView;

@interface WhiteRoom : NSObject

- (instancetype)initWithBridge:(WhiteBoardView *)bridge;

#pragma mark - Action API
- (void)setGlobalState:(WhiteGlobalState *)modifyState;
- (void)setMemberState:(WhiteMemberState *)modifyState;

- (void)setViewMode:(WhiteViewMode)viewMode;
- (void)setViewSizeWithWidth:(CGFloat)width height:(CGFloat)height;
- (void)disconnect:(void (^) (void))completeHandler;
- (void)updateTextarea:(WhiteTextareaBox *)textareaBox;
- (void)insertNewPage:(NSInteger)page;
- (void)removePage:(NSInteger)page;
- (void)insertImage:(WhiteImageInformation *)imageInfo;
- (void)pushPptPages:(NSArray<WhitePptPage *>*)pptPages;
- (void)completeImageUploadWithUuid:(NSString *)uuid src:(NSString *)src;

//- (void)dispatchMagixEvent:(NSString *)eventName payload:(NSString *)payload;
//- (void)waitMagixEvent:(BOOL (^) (id akkoEvent))filter completeHandler:(void (^)(id akkoEvent))completeHandler;
- (void)convertToPointInWorld:(CGPoint)point result:(void (^) (CGPoint point))result;
//- (void)zoomChangeScale:(CGFloat)scale;

#pragma mark - Get State API

- (void)getGlobalStateWithResult:(void (^) (WhiteGlobalState *state))result;
- (void)getMemberStateWithResult:(void (^) (WhiteMemberState *state))result;
- (void)getRoomMembersWithResult:(void (^) (NSArray<WhiteRoomMember *> *roomMembers))result;
//push 时，用的是WhitePptPage
- (void)getPptImagesWithResult:(void (^) (NSArray<NSString *> *pptPages))result;
- (void)getTransformWithResult:(void (^) (WhiteLinearTransformationDescription *transform))result;
- (void)getBroadcastStateWithResult:(void (^) (WhiteBroadcastState *state))result;

@end
