//
//  WhiteEvent.h
//  WhiteSDK
//
//  Created by yleaf on 2018/10/9.
//

#import "WhiteObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhiteEvent : WhiteObject
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *payload;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, strong) NSString *authorId;
@end

NS_ASSUME_NONNULL_END
