//
//  WhitePlayerConfig.h
//  WhiteSDK
//
//  Created by yleaf on 2019/3/1.
//

#import "WhiteObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhitePlayerConfig : WhiteObject

@property (nonatomic, copy) NSString *room;
@property (nonatomic, copy, nullable) NSString *slice;
@property (nonatomic, strong, nullable) NSNumber *beginTimestamp;
@property (nonatomic, strong, nullable) NSNumber *duration;
@property (nonatomic, strong, nullable) NSString *audioUrl;
@end

NS_ASSUME_NONNULL_END
