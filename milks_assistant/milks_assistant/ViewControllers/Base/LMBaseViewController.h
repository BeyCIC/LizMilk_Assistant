//
//  LMBaseViewController.h
//  milks_assistant
//
//  Created by JasonHuang on 17/3/31.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SetpasswordViewController;

@interface LMBaseViewController : UIViewController

- (void)setRoundBtn:(UIButton*)button;

@property (nonatomic,strong)SetpasswordViewController *gestureCtl;

- (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg ok:(NSString *)ok cancel:(NSString *)cancel;

@end
