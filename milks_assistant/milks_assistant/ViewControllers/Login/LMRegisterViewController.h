//
//  LMRegisterViewController.h
//  milks_assistant
//
//  Create by JasonHuang on 2017/5/7.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMBaseViewController.h"

@protocol registerSuccessDelegate <NSObject>

- (void) cancel;

- (void) registerSuc;

- (void) loginBtnaction;


@end

@interface LMRegisterViewController : LMBaseViewController

@property(nonatomic,weak)id<registerSuccessDelegate>delegate;

@end
