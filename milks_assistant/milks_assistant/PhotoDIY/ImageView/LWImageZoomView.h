//
//  LWImageZoomView.h
//  PhotoDIY
//
//  Create by luowei on 16/7/27.
//  Copyright (c) 2016 wodedata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWImageZoomView : UIScrollView<UIScrollViewDelegate>

@property(nonatomic) NSInteger currentIndex;

@property(nonatomic, strong)  UIImageView *imageView;

@property(nonatomic, strong)  NSLayoutConstraint *topConstraint;
@property(nonatomic, strong)  NSLayoutConstraint *bottomConstraint;
@property(nonatomic, strong)  NSLayoutConstraint *leadingConstraint;
@property(nonatomic, strong)  NSLayoutConstraint *trainingConstraint;

- (void)setImage:(UIImage *)image;

- (void)rotateRight;

- (void)rotateLeft;

- (void)flipHorizonal;

@end
