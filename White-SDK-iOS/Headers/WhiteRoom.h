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
#import "WhiteSceneState.h"
#import "WhitePanEvent.h"

@class WhiteBoardView;

NS_ASSUME_NONNULL_BEGIN

@interface WhiteRoom : NSObject

#pragma mark - Property
@property (nonatomic, copy, readonly) NSString *uuid;

#pragma mark - Set API

- (void)setGlobalState:(WhiteGlobalState *)modifyState DEPRECATED_MSG_ATTRIBUTE("globalState 目前没有可以更改的内容，切换scence页面，请使用setScencePath API");

/**
 切换至具体页面

 @param path 具体的页面路径
 
 当传入的页面路径有以下情况时，会导致调用该方法失败
 
 1. 路径不合法。请通过之前的章节确保页面路径符合规范。
 2. 路径对应的页面不存在。
 3. 路径对应的是页面组。注意页面组和页面是不一样的。
 
 TODO:API 报错反馈
 */
- (void)setScencePath:(NSString *)path;

/** 目前主要用来切换教具 */
- (void)setMemberState:(WhiteMemberState *)modifyState;

/** 切换用户视角模式 */
- (void)setViewMode:(WhiteViewMode)viewMode;

- (void)setViewSizeWithWidth:(CGFloat)width height:(CGFloat)height DEPRECATED_MSG_ATTRIBUTE("use refreshViewSize");

#pragma mark - action API

/**
 如果白板窗口大小改变。应该重新调用该方法刷新尺寸
 //TODO:明确普通 layout 变化时，是否需要手动调用。
 */
- (void)refreshViewSize;

/** 主动断开连接 */
- (void)disconnect:(void (^) (void))completeHandler;

/**
 缩小放大白板
 @param scale 相对于原始大小的比例。
 TODO: 在文档中明确，scale 是相对原始大小的比例，还是相对于当前大小的比例。
 */
- (void)zoomChange:(CGFloat)scale;

/**
 进入只读模式，不响应用户任何手势
 @param readonly 是否进入只读模式
 */
- (void)disableOperations:(BOOL)readonly;

#pragma mark - Scene API

//TODO:需要先理解页面（场景）的概念，理解绝对路径和name

/**
 插入，或许新建多个页面

 @param dir scene 页面组名称，相当于目录
 @param scenes WhiteScence 实例；在生成 WhiteScence 时，可以同时配置 ppt
 @param index 选择在页面组，插入的位置。index 即为新 scence 的 index 位置。如果想要放在最末尾，可以传入 NSUIntegerMax。
 */
- (void)putScenes:(NSString *)dir scenes:(NSArray<WhiteScene *> *)scenes index:(NSUInteger)index;

/**

 当有
 /ppt/page0
 /ppt/page1
 传入 "/ppt/page0" 时，则只删除对应页面。
 传入 "/ppt" 时，会将两个页面一起移除。

 @param dirOrPath 页面具体路径，或者为页面组路径
 */
- (void)removeScenes:(NSString *)dirOrPath;


/**
 移动/重命名页面

 @param source 想要移动的页面的绝对路径
 @param target 目标路径。如果是文件夹，则将 source 移入；否则，移动的同时重命名。
 */
- (void)moveScene:(NSString *)source target:(NSString *)target;

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

/** 封装上述两个 API */
- (void)insertImage:(WhiteImageInformation *)imageInfo src:(NSString *)src;

#pragma mark - Custom Event
// 发送自定义事件，详细内容，可以查看 https://developer.herewhite.com/#/iOS_detail_api?id=%E8%87%AA%E5%AE%9A%E4%B9%89%E6%B6%88%E6%81%AF
- (void)dispatchMagixEvent:(NSString *)eventName payload:(NSDictionary *)payload;
- (void)addMagixEventListener:(NSString *)eventName;
- (void)removeMagixEventListener:(NSString *)eventName;

#pragma mark - Get State API

- (void)getGlobalStateWithResult:(void (^) (WhiteGlobalState *state))result;
- (void)getSceneStateWithResult:(void (^) (WhiteSceneState *state))result;
- (void)getMemberStateWithResult:(void (^) (WhiteMemberState *state))result;
- (void)getRoomMembersWithResult:(void (^) (NSArray<WhiteRoomMember *> *roomMembers))result;
- (void)getRoomPhaseWithResult:(void (^) (WhiteRoomPhase phase))result;

/** 获取当前缩放比例 */
- (void)getZoomScaleWithResult:(void (^) (CGFloat scale))result;

/**
 获取所有 ppt 图片，回调内容为所有 ppt 图片的地址。
 @param result 如果当前页面，没有插入过 PPT，则该页面会返回一个空字符串
 */
- (void)getPptImagesWithResult:(void (^) (NSArray<NSString *> *pptPages))result DEPRECATED_MSG_ATTRIBUTE("使用 getScenesWithResult:");

/** 获取所有页面的信息 */
- (void)getScenesWithResult:(void (^) (NSArray<WhiteScene *> *scenes))result;
/** 获取当前视角模式 */
- (void)getBroadcastStateWithResult:(void (^) (WhiteBroadcastState *state))result;

#pragma mark - Experimental API

/** 该 API 为实验性 API，不保证未来兼容性 */
- (void)externalDeviceEventDown:(WhitePanEvent *)event;
/** 该 API 为实验性 API，不保证未来兼容性 */
- (void)externalDeviceEventMove:(WhitePanEvent *)event;
/** 该 API 为实验性 API，不保证未来兼容性 */
- (void)externalDeviceEventUp:(WhitePanEvent *)event;
/** 该 API 为实验性 API，不保证未来兼容性 */
- (void)externalDeviceEventLeave:(WhitePanEvent *)event;

@end

NS_ASSUME_NONNULL_END
