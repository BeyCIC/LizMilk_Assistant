//
//  UPWMUserInterfaceManager.h
//  wallet_merchant
//
//  Created by renjie on 2017/1/6.
//  Copyright © 2017年 任杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UPXAlertView.h"
#import "UPWLoadingView.h"
#import "UPXWaitingView.h"
#import "UPXToast.h"

@interface UPWMUserInterfaceManager : NSObject

+ (UPWMUserInterfaceManager*)sharedManager;


#pragma mark -
#pragma mark 对话框/等待框相关函数
- (void)showWaitingView:(NSString*)title;
- (void)hideWaitingView;

- (void)showLoadingWithMessage:(NSString*)message;
- (void)dismissLoading;

- (void)showLoadingView2;
- (void)showLoadingView2WithCenter:(CGPoint)pt;
- (void)dismissLoading2;


- (void)showFlashInfo:(NSString*)info;
- (void)showFlashInfo:(NSString*)info withTime:(NSInteger)time;
- (void)showFlashInfo:(NSString*)info withDismissBlock:(dispatch_block_t)dismissBlock;

- (void)showFlashInfo:(NSString*)info withImage:(UIImage*)image;
- (void)showFlashInfo:(NSString*)info withImage:(UIImage*)image withDismissBlock:(dispatch_block_t)dismissBlock;

- (UPXAlertView*)showAlertWithTitle:(NSString*)title
                            message:(NSString*)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                   otherButtonTitle:(NSString *)otherButtonTitle
                      completeBlock:(UPXAlertViewBlock)block;

- (void)dismissAll;


@end
