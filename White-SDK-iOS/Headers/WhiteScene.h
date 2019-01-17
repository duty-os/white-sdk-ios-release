//
//  WhiteScene.h
//  WhiteSDK
//
//  Created by yleaf on 2019/1/11.
//

#import "WhiteObject.h"
#import "WhitePptPage.h"
NS_ASSUME_NONNULL_BEGIN

@interface WhiteScene : WhiteObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, assign, getter=isEmpty) BOOL empty;
@property (nonatomic, strong, readonly, nullable) WhitePptPage *ppt;
@end

NS_ASSUME_NONNULL_END
