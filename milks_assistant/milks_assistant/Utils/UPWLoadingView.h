//
//  UPWLoadingView.h
//  wallet
//
//  Created by qcao on 14/10/22.
//  Copyright (c) 2014年 China Unionpay Co.,Ltd. All rights reserved.
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
