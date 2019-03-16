//
//  WhiteBaseCallbacks.h
//  WhiteSDK
//
//  Created by yleaf on 2019/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WhiteCommonCallbackDelegate <NSObject>

@optional

/**
 当sdk出现未捕获的全局错误时，会在此处对抛出 NSError 对象
 */
- (void)throwError:(NSError *)error;

/*
 启用改功能，需要在初始化 SDK 时，在 WhiteSDKConfig 设置 enableInterrupterAPI 为 YES; 初始化后，无法更改。
 之后，在调用插入图片API/插入scene 时，会回调该 API，允许拦截修改最后传入的图片地址。
 在回放中，也会持续调用。

 */
- (NSString *)urlInterrupter:(NSString *)url;

@end

@interface WhiteCommonCallbacks : NSObject

@property (nonatomic, weak) id<WhiteCommonCallbackDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
