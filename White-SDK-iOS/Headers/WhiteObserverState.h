//
//  WhiteObserverState.h
//  WhiteSDK
//
//  Created by yleaf on 2019/3/2.
//

#import "WhiteObject.h"
#import "WhitePlayerConsts.h"
#import "WhiteMemberInformation.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteObserverState : WhiteObject

@property (nonatomic, assign, readonly) WhiteObserverMode mode;
@property (nonatomic, strong, nullable, readonly) NSNumber *observerId;
@property (nonatomic, copy, readonly) NSString *followUserId;
@property (nonatomic, strong, readonly) NSArray<WhiteMemberInformation *> *roomMembers;

@end

NS_ASSUME_NONNULL_END
