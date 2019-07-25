//
//  WhiteDisplayer.h
//  WhiteSDK
//
//  Created by yleaf on 2019/7/1.
//

#import <Foundation/Foundation.h>
#import "WhiteConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteDisplayer : NSObject

/**
 会被转换成十六进制色值，目前不支持透明度设置，只会传递透明度。该背景为用户本地修改值，不会被同步。
 */
@property (nonatomic, strong) UIColor *backgroundColor;

#pragma mark - 视角
- (void)moveCamera:(WhiteCameraConfig *)camera;
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
