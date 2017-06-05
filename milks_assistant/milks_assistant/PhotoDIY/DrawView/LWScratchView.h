//
//  LWScratchView.h
//  PhotoDIY
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 16/9/30.
//  Copyright © 2016年 JasonHuang. All rights reserved.
//  马赛克草稿用的

#import <UIKit/UIKit.h>

@interface LWScratchView : UIView{
    CGPoint previousTouchLocation;
    CGPoint currentTouchLocation;

    CGImageRef hideImage;
    CGImageRef scratchImage;

    CGContextRef contextMask;
}

@property (nonatomic, assign) float sizeBrush;


- (void)setHideView:(UIView *)hideView;



@end
