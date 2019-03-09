//
//  WhiteSdkConfiguration.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import "WhiteObject.h"

typedef NS_ENUM(NSInteger, WhiteDeviceType) {
    WhiteDeviceTypeTouch,
    WhiteDeviceTypeDesktop,
};

@interface WhiteSdkConfiguration : WhiteObject

+ (instancetype)defaultConfig;

/** default value: Touch。native 端，无需关注该属性。 */
@property (nonatomic, assign) WhiteDeviceType deviceType;
/** default value: 0.1 */
@property (nonatomic, assign) CGFloat zoomMinScale;
/** default value: 10 */
@property (nonatomic, assign) CGFloat zoomMaxScale;

/** 设置后，web 会将大部分调用回调给SDK，SDK 会打印 web 中的 function，以及收到的参数 */
@property (nonatomic, assign) BOOL debug;

/**
  图片拦截功能。
  当开启图片拦截后
  回调由原来的 WhiteRoomCallbackDelegate 切换到了 SDK 的 WhiteCommonCallbackDelegate，中。
  以此保证，回放时，也能够正确拦截图片
 */
@property (nonatomic, assign) BOOL enableInterrupterAPI;

@end
