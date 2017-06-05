//
//  LWDrawView.h
//  PhotoDIY
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 16/7/27.
//  Copyright © 2016年 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWScratchView;
@class LWScrawlView;
@class LWDrawBar;

@interface LWDrawView : UIView

@property(nonatomic,strong)  UIImageView *mosaicImageView;
@property(nonatomic,strong)  LWScratchView *scratchView;
@property(nonatomic,strong)  LWScrawlView *scrawlView;

@property(nonatomic,strong)  LWDrawBar *drawBar;
@property(nonatomic,strong)  UIButton *mosaicBtn;
@property(nonatomic,strong)  UIButton *deleteBtn;


- (void)openOrCloseMosaic:(UIButton *)mosaicButton;

- (void)setImage:(UIImage *)image;

@end
