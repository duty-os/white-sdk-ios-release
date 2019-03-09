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
 调用插入图片API时，可以通过此方法，对使用插入图片API(completeImageUploadWithUuid:src:) 中，传入的 src 进行修改。
 启用改功能，需要在初始化 SDK 时，在 WhiteSDKConfig 设置 enableInterrupterAPI 为 YES。初始化后，无法更改。
 */
- (NSString *)urlInterrupter:(NSString *)url;

@end

@interface WhiteCommonCallbacks : NSObject

@property (nonatomic, weak) id<WhiteCommonCallbackDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
