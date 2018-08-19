//
//  WhiteRoomMember.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"
#import "WhiteMemberInformation.h"

@interface WhiteRoomMember : WhiteObject
@property (nonatomic, assign) NSInteger memberId;
@property (nonatomic, assign) BOOL isRtcConnected;
@property (nonatomic, copy) NSString *currentApplianceName;
@property (nonatomic, strong) WhiteMemberInformation *information;
@end
