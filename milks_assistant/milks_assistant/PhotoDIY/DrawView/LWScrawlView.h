//
//  LWScrawlView.h
//  PhotoDIY
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 16/9/30.
//  Copyright © 2016年 wodedata. All rights reserved.
//  涂鸦视图

#import <UIKit/UIKit.h>

@interface LWScrawlView : UIView

//是否启用橡皮擦模式
- (void) eraseModeOn:(BOOL)is;

//画板重置
-(void) resetDrawing;

@end
