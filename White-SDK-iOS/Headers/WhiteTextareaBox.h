//
//  WhiteTextareaBox.h
//  WhiteSDK
//
//  Created by leavesster on 2018/8/15.
//

#import "WhiteObject.h"

@interface WhiteTextareaLine: WhiteObject

@property (nonatomic, assign) CGFloat dx;
@property (nonatomic, assign) CGFloat dy;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, assign) CGFloat textLength;

@end

@interface WhiteTextareaBox : WhiteObject

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *originalText;
@property (nonatomic, copy) NSArray<WhiteTextareaLine *> *textareaLine;

@end
