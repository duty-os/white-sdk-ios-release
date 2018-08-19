//
//  MemberState.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/14.
//

#import "WhiteObject.h"

typedef NSString * WhiteApplianceNameKey;

UIKIT_EXTERN WhiteApplianceNameKey const AppliancePencil;
UIKIT_EXTERN WhiteApplianceNameKey const ApplianceSelector;
UIKIT_EXTERN WhiteApplianceNameKey const ApplianceText;
UIKIT_EXTERN WhiteApplianceNameKey const ApplianceEllipse;
UIKIT_EXTERN WhiteApplianceNameKey const ApplianceRectangle;
UIKIT_EXTERN WhiteApplianceNameKey const ApplianceEraser;

@interface WhiteMemberState : WhiteObject
@property (nonatomic, copy) WhiteApplianceNameKey currentApplianceName;
@property (nonatomic, copy) NSArray<NSNumber *> *strokeColor;
@property (nonatomic, strong) NSNumber *strokeWidth;
@property (nonatomic, strong) NSNumber *textSize;
@end
