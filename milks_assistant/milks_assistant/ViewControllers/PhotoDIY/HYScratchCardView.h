//
//  HYScratchCardView.h
//  Test
//  爱你一生一世，刘磊璐
//  Created by JasonHuang on 17-5-25.
//  Copyright (c) 2017年 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYScratchCardView : UIView
/**
 要刮的底图.
 */
@property (nonatomic, strong) UIImage *image;
/**
 涂层图片.
 */
@property (nonatomic, strong) UIImage *surfaceImage;

@property (nonatomic, strong) UIImageView *surfaceImageView;

@property (nonatomic, strong) CALayer *imageLayer;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

- (UIImage*)getDrawImage;

- (void)clearDrawBoard;
@end
