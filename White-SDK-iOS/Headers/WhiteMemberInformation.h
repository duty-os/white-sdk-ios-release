//
//  WhiteMemberInformation.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"


@interface WhiteMemberInformation : WhiteObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSString *nickName;
@property (nonatomic, copy) NSString *currentApplianceName;

@end
