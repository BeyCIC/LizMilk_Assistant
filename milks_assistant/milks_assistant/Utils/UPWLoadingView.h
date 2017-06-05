//
//  UPWLoadingView.h
//  wallet
//  爱你一生一世 刘磊璐
//  Create by JasonHuang on 14/10/22.
//  Copyright (c) 2014年 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ENormalLoadingStyle,
    ETextLoadingStyle
}ELoadingStyle;

@interface UPWLoadingView : UIView

@property (nonatomic, strong) NSString *text;

- (void)setLoadingStyle:(ELoadingStyle)style;

- (void)startAnimation;

- (void)stopAnimation;

@end
