//
//  WhiteDisplayer.h
//  WhiteSDK
//
//  Created by yleaf on 2019/7/1.
//

#import <Foundation/Foundation.h>
#import "WhiteConfig.h"
#import "WhiteCameraBound.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteDisplayer : NSObject

/**
 会被转换成十六进制色值，目前不支持透明度设置，只会传递色值。
 该属性只修改用户本地显示，不会被同步。
 */
@property (nonatomic, strong) UIColor *backgroundColor;

#pragma mark - 视角
/**
 设置视野范围

 @param cameraBound 视野范围描述类
 */
//- (void)setCameraBound:(WhiteCameraBound *)cameraBound;

/**
 移动视角中心

 @param camera 视角描述类
 */
- (void)moveCamera:(WhiteCameraConfig *)camera;

/**
 移动到特定的视野范围

 @param rectange 视野描述类
 */
- (void)moveCameraToContainer:(WhiteRectangleConfig *)rectange;

#pragma mark - 截图

/**
 截取用户切换时，看到的场景内容，不是场景内全部内容。
 图片支持：只有当图片服务器支持跨域，才可以显示在截图中。（请真机中运行）

 @param scenePath 想要截取场景的场景路径，例如 /init
 @param completionHandler 回调函数，image 可能为空
 */
- (void)getScenePreviewImage:(NSString *)scenePath completion:(void (^)(UIImage * _Nullable image))completionHandler;


/**
 场景封面截图，会包含场景内全部内容
 图片支持：只有当图片服务器支持跨域，才可以显示在截图中。（请真机中运行）

 @param scenePath 想要截取场景的场景路径，例如 /init
 @param completionHandler  回调函数，image 可能为空
 */
- (void)getSceneSnapshotImage:(NSString *)scenePath completion:(void (^)(UIImage * _Nullable image))completionHandler;

@end

NS_ASSUME_NONNULL_END
