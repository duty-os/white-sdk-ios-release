//
//  WhiteRoomClientParams.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/17.
//

#import "WhiteObject.h"

@interface WhiteRoomClientParams : WhiteObject

@property (nonatomic, copy) NSString *previousUserId;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *roomToken;
@property (nonatomic, copy) NSString *sessionToken;
@property (nonatomic, copy) NSString *userToken;

@end
