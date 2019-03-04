//
//  WhiteSceneState.h
//  WhiteSDK
//
//  Created by yleaf on 2019/2/25.
//

#import "WhiteObject.h"
#import "WhiteScene.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteSceneState : WhiteObject
//当前场景组的所有场景
@property (nonatomic, nonnull, strong, readonly) WhiteScene *scenes;
//当前场景组目录
@property (nonatomic, nonnull, strong, readonly) NSString *scenePath;
//当前场景，在 scenes 数组中的索引位置。
@property (nonatomic, assign, readonly) NSInteger index;
@end

NS_ASSUME_NONNULL_END
