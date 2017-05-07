//
//  LMLoginViewController.h
//  milks_assistant
//
//  Created by JasonHuang on 2017/5/7.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMBaseViewController.h"

@protocol loginVCdelegate <NSObject>

- (void)loginFailed;

- (void)loginSuccess;

- (void)gotoRegister;

@end

@interface LMLoginViewController : LMBaseViewController

@property(nonatomic,weak)id<loginVCdelegate>delegate;

@end
