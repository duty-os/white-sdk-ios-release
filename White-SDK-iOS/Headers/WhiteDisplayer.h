//
//  WhiteDisplayer.h
//  WhiteSDK
//
//  Created by yleaf on 2019/7/1.
//

#import <Foundation/Foundation.h>
#import "WhiteObject.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AnimationMode) {
    AnimationModeContinuous,    //带动画，默认
    AnimationModeImmediately,   //瞬间切换
};

@interface WhiteCameraConfig : WhiteObject

@property (nonatomic, strong, nullable) NSNumber *centerX;
@property (nonatomic, strong, nullable) NSNumber *centerY;
@property (nonatomic, strong, nullable) NSNumber *scale;
/**
 AnimationMode 默认为 AnimationModeContinuous，
 其他属性，均为可选值，需要使用 NSNumber
 */
@property (nonatomic, assign) AnimationMode animationMode;

@end

@interface WhiteRectangleConfig : WhiteObject

- (instancetype)initWithInitialPosition:(CGFloat)width height:(CGFloat)height;
/** 移动到初始位置，并根据宽高进行缩放 */
- (instancetype)initWithInitialPosition:(CGFloat)width height:(CGFloat)height animation:(AnimationMode)mode;

/** 白板内部坐标，以中心点为初始点，此处 originX: - width / 2，originY: -height /2 */
- (instancetype)initWithOriginX:(CGFloat)originX originY:(CGFloat)originY width:(CGFloat)width height:(CGFloat)height;
- (instancetype)initWithOriginX:(CGFloat)originX originY:(CGFloat)originY width:(CGFloat)width height:(CGFloat)height animation:(AnimationMode)mode;

@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) AnimationMode animationMode;

@end

@interface WhiteDisplayer : NSObject

#pragma mark - 视角
- (void)moveCamera:(WhiteCameraConfig *)camera;
- (void)moveCameraToContainer:(WhiteRectangleConfig *)rectange;

#pragma mark - 截图

/**
 截取用户切换时，看到的场景内容，不是场景内全部内容。
 FIXME：图片支持：只有当图片服务器支持跨域，才可以显示在截图中

 @param scenePath 想要截取场景的场景路径，例如 /init
 @param completionHandler 回调函数，image 可能为空
 */
- (void)getScenePreviewImage:(NSString *)scenePath completion:(void (^)(UIImage * _Nullable image))completionHandler;


/**
 场景封面截图，会包含场景内全部内容
 FIXME：图片支持：只有当图片服务器支持跨域，才可以显示在截图中

 @param scenePath 想要截取场景的场景路径，例如 /init
 @param completionHandler  回调函数，image 可能为空
 */
- (void)getSceneSnapshotImage:(NSString *)scenePath completion:(void (^)(UIImage * _Nullable image))completionHandler;

@end

NS_ASSUME_NONNULL_END
