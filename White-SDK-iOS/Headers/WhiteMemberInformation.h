//
//  WhiteMemberInformation.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteMemberInformation : WhiteObject

- (instancetype)initWithUserId:(NSString *)userId name:(NSString *)nickName avatar:(NSString *)avatarUrl;

/** 原样返回的数字，目前无使用 */
@property (nonatomic, assign, readwrite) NSInteger id;
/** 想显示的名字，native 端，不会显示，web 端自定义时，可以自行读取 */
@property (nonatomic, copy, readonly) NSString *nickName;
/** 鼠标/手指 头像图片地址 */
@property (nonatomic, copy, readonly, nullable) NSString *avatar;
/** 用户 uuid，请保证唯一性 */
@property (nonatomic, copy, readonly) NSString *userId;

@end

NS_ASSUME_NONNULL_END
