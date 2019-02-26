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

/** default value: Touch */
@property (nonatomic, assign) WhiteDeviceType deviceType;
/** default value: 0.1 */
@property (nonatomic, assign) CGFloat zoomMinScale;
/** default value: 10 */
@property (nonatomic, assign) CGFloat zoomMaxScale;

@property (nonatomic, assign) BOOL enableDebug;
@end
