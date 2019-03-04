//
//  WhiteCursorView.h
//  WhiteSDK
//
//  Created by yleaf on 2019/3/4.
//

#import "WhiteObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteCursorView : WhiteObject

@property (nonatomic, readonly, assign) NSInteger memberId;
@property (nonatomic, readonly, assign) NSInteger x;
@property (nonatomic, readonly, assign) NSInteger y;

@end

NS_ASSUME_NONNULL_END
