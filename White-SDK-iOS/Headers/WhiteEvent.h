//
//  WhiteEvent.h
//  WhiteSDK
//
//  Created by yleaf on 2018/10/9.
//

#import "WhiteObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteEvent : WhiteObject
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSDictionary *payload;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, strong) NSString *authorId;
/** 兼容部分情况下，其他端发送的 payload 为string 的问题。 */
@property (nonatomic, strong) NSString *stringPayload;
@end

NS_ASSUME_NONNULL_END
