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
- (instancetype)initWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken memberInfo:(WhiteMemberInformation * _Nullable)memberInfo;

@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *roomToken;
@property (nonatomic, copy, nullable) WhiteMemberInformation *memberInfo;

@end

NS_ASSUME_NONNULL_END
