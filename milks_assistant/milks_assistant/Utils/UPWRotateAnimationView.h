//
//  UPRotateAnimationView.h
//  UPWallet
//
//  Created by wxzhao on 14-8-2.
//  Copyright (c) 2014年 unionpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPWRotateAnimationView : UIView

@property(nonatomic,strong) UIImage* image;
@property(nonatomic) BOOL showRotateImage;

- (void)startRotating;
- (void)stopRotating;

@end
