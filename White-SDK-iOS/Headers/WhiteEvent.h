//
//  WhiteEvent.h
//  WhiteSDK
//
//  Created by yleaf on 2018/10/9.
//

#import "WhiteObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteEvent : WhiteObject

/** 注册事件时的事件名 */
@property (nonatomic, strong) NSString *eventName;
/** 发送自定义事件时，附带的信息 */
@property (nonatomic, strong) NSDictionary *payload;

/** 房间号 */
@property (nonatomic, strong, readonly) NSString *uuid;

/**
 发送事件的用户角色。
 system，app，custom，magix。
 自定义事件为 custom
 */
@property (nonatomic, strong, readonly) NSString *scope;

/**
 发送事件的用户
 */
@property (nonatomic, strong, readonly) NSString *authorId;

@end

NS_ASSUME_NONNULL_END
