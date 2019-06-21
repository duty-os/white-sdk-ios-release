//
//  WhiteRoomConfig.h
//  WhiteSDK
//
//  Created by yleaf on 2019/3/30.
//

#import "WhiteObject.h"
#import "WhiteMemberInformation.h"
NS_ASSUME_NONNULL_BEGIN

@interface WhiteRoomConfig : WhiteObject

- (instancetype)initWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken;
- (instancetype)initWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken memberInfo:(WhiteMemberInformation * _Nullable)memberInfo  __attribute__((deprecated("memberInfo is deprecated, please use userPayload")));;
- (instancetype)initWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken userPayload:(id _Nullable)userPayload;

@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *roomToken;

/**
 加入房间时，允许带入用户数据（限制：允许转换为 JSON，或者单纯的 NSString，数字 NSNumber）
 */
@property (nonatomic, copy) id userPayload;
@property (nonatomic, copy, nullable) WhiteMemberInformation *memberInfo __attribute__((deprecated("memberInfo is deprecated, please use userPayload")));

@end

NS_ASSUME_NONNULL_END
