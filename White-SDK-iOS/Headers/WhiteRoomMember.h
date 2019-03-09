//
//  WhiteRoomMember.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"
#import "WhiteMemberInformation.h"

@interface WhiteRoomMember : WhiteObject

@property (nonatomic, copy, readonly) NSString *currentApplianceName;
@property (nonatomic, assign, readonly) NSInteger memberId;
@property (nonatomic, assign, readonly) BOOL isRtcConnected;
@property (nonatomic, strong, readonly) WhiteMemberInformation *information;

@end
