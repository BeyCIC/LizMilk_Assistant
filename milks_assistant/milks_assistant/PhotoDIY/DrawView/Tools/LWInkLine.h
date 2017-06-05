//
//  爱你一生一世 刘磊璐
// Create by JasonHuang on 16/10/8.
// Copyright (c) 2016 JasonHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LWInkLine : NSObject

@property (nonatomic,assign) BOOL isEraseMode;
@property (nonatomic, strong) NSMutableArray *lineArr;
@property (nonatomic, assign) NSInteger colorIndex;
@property (nonatomic, assign) CGFloat lineWidth;

@end
