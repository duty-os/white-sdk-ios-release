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
@property (nonatomic, nonnull, strong, readonly) WhiteScene *scenes;
@property (nonatomic, nonnull, strong, readonly) NSString *scenePath;
@property (nonatomic, assign, readonly) NSInteger index;
@end

NS_ASSUME_NONNULL_END
