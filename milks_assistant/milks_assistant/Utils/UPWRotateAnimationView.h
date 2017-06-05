//
//  UPRotateAnimationView.h
//  UPWallet
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 14-8-2.
//  Copyright (c) 2014年 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPWRotateAnimationView : UIView

@property(nonatomic,strong) UIImage* image;
@property(nonatomic) BOOL showRotateImage;

- (void)startRotating;
- (void)stopRotating;

@end
