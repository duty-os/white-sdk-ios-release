//
//  WhiteMemberInformation.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"


@interface WhiteMemberInformation : WhiteObject

@property (nonatomic, assign, readonly) NSInteger id;
@property (nonatomic, assign, readonly) NSString *nickName;
@property (nonatomic, copy, readonly) NSString *avatar;

@end
