//
//  LMBaseViewController.h
//  milks_assistant
//
//  Created by JasonHuang on 17/3/31.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMBaseViewController : UIViewController

- (void)setRoundBtn:(UIButton*)button;

- (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg ok:(NSString *)ok cancel:(NSString *)cancel;

@end
