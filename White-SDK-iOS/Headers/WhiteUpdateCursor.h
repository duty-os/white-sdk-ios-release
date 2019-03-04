//
//  WhiteUpdateCursor.h
//  WhiteSDK
//
//  Created by yleaf on 2019/3/4.
//

#import "WhiteObject.h"
#import "WhiteCursorView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WhiteUpdateCursor : WhiteObject
@property (nonatomic, readonly, copy) NSArray<WhiteCursorView *> *appearSet;
@property (nonatomic, readonly, copy) NSArray<WhiteCursorView *> *disappearSet;
@property (nonatomic, readonly, copy) NSArray<WhiteCursorView *> *updateSet;
@end

NS_ASSUME_NONNULL_END
