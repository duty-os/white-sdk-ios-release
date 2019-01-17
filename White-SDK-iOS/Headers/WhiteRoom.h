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
#import "WhiteEvent.h"
#import "WhiteScene.h"

@class WhiteBoardView;

@interface WhiteRoom : NSObject

#pragma mark - Property
@property (nonatomic, copy, readonly) NSString *uuid;

#pragma mark - Set API

- (void)setGlobalState:(WhiteGlobalState *)modifyState;
- (void)setMemberState:(WhiteMemberState *)modifyState;

/** 切换用户视角 */
- (void)setViewMode:(WhiteViewMode)viewMode;
- (void)setViewSizeWithWidth:(CGFloat)width height:(CGFloat)height DEPRECATED_MSG_ATTRIBUTE("use refreshViewSize");

#pragma mark - action API

/** 如果白板窗口大小改变。应该重新调用该方法刷新尺寸。 */
- (void)refreshViewSize;

/** 主动断开连接 */
- (void)disconnect:(void (^) (void))completeHandler;

- (void)updateTextarea:(WhiteTextareaBox *)textareaBox;
/** 放大缩小 */
- (void)zoomChange:(CGFloat)scale;
/** 进入只读模式，不响应用户任何手势 */
- (void)disableOperations:(BOOL)readonly;

/**
 插入空白白板页面
 @param page 为插入白板的 index 位置
 */
- (void)insertNewPage:(NSInteger)page;

/* 移除白板页面
 白板只有一页时：则会移除当前页，并同时创建新页面。
 白板有多页：
    移除页面的 index 小于当前页，仍然保持当前页面，WhiteGlobalState 中的 currentIndex -1。
    移除页面是最后一页同时也是最后一页，则会自动移动到上一页，WhiteGlobalState 中的 currentIndex -1。
    其他情况，当前页面 index 不变化，当前页面不变
 */
- (void)removePage:(NSInteger)page;

/**
 插入 PPT，参数查看WhitePptPage
 PPT插入后，White SDK 会创建多个页面（默认仍然停留在当前页）
 */
- (void)pushPptPages:(NSArray<WhitePptPage *>*)pptPages;

#pragma mark - Image API

/**
 1. 先使用 insertImage API，插入占位图
 2. 再通过 completeImageUploadWithUuid:src: 替换内容
 详细内容，可以查看 https://developer.herewhite.com/#/iOS_detail_api?id=%E6%8F%92%E5%85%A5%E5%9B%BE%E7%89%87
 */
- (void)insertImage:(WhiteImageInformation *)imageInfo;

/**
 替换占位图中的内容

 @param uuid insertImage API 中，imageInfo 传入的图片 uuid
 @param src 图片的网络地址
 */
- (void)completeImageUploadWithUuid:(NSString *)uuid src:(NSString *)src;

#pragma mark - Custom Event
// 发送自定义事件，详细内容，可以查看 https://developer.herewhite.com/#/iOS_detail_api?id=%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B6%88%E6%81%AF
- (void)dispatchMagixEvent:(NSString *)eventName payload:(NSDictionary *)payload;
- (void)addMagixEventListener:(NSString *)eventName;
- (void)removeMagixEventListener:(NSString *)eventName;

#pragma mark - Get State API

- (void)getGlobalStateWithResult:(void (^) (WhiteGlobalState *state))result;
- (void)getMemberStateWithResult:(void (^) (WhiteMemberState *state))result;
- (void)getRoomMembersWithResult:(void (^) (NSArray<WhiteRoomMember *> *roomMembers))result;
- (void)getRoomPhaseWithResult:(void (^) (WhiteRoomPhase phase))result;

/** 获取当前缩放比例 */
- (void)getZoomScaleWithResult:(void (^) (CGFloat scale))result;

/**
 获取所有 ppt 图片，回调内容为所有 ppt 图片的地址。
 @param result 如果当前页面，没有插入过 PPT，则该页面会返回一个空字符串
 */
- (void)getPptImagesWithResult:(void (^) (NSArray<NSString *> *pptPages))result;

/* 获取所有页面的信息 */
- (void)getScenesWithResult:(void (^) (NSArray<WhiteScene *> *scenes))result;
/* 获取当前视角模式 */
- (void)getBroadcastStateWithResult:(void (^) (WhiteBroadcastState *state))result;

@end
