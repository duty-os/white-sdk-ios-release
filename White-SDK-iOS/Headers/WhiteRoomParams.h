//
//  WhiteRoomParams.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"

@interface WhiteRoomParams : WhiteObject

- (instancetype)initWithUuid:(NSString *)uuid roomToken:(NSString *)roomToken;

@property (nonatomic, assign) NSInteger previousUserId;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *roomToken;
@property (nonatomic, copy) NSString *sessionToken;
@property (nonatomic, copy) NSString *userToken;

@end
