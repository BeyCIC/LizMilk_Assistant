//
//  UPXTouchIDManager.h
//  wallet
//
//  Created by mac on 16/6/22.
//  Copyright © 2016年 JasonHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

//@class UPXTouchIDViewController;

@interface UPXTouchIDManager : NSObject

#define kTouchIDKeyChainIdentifer    @"touchIDKeyChainIdentifer1"
#define kKeyChainHadSetTouchIDUsersKey   kSecValueData

#define kHasSetTouchIDValue @"1"
#define kNotSetTouchIDValue @"0"


/**
 *  TouchIdValidationFailureBack
 *
 *  @param result LAError枚举
 */
typedef void(^TouchIdValidationFailureBack)(LAError result);

//@property (nonatomic, strong)  UPXTouchIDViewController *touchIDVC;

// 单例
+ (instancetype) sharedInstance;

// 当前设备TouchID是否可用
- (BOOL)isTouchIdAvailable;

// 当前用户TouchID是否开着
- (BOOL)currentUserOpenTouchID;

// 当前用户TouchID是否设置过
- (BOOL)currentUserSetTouchID;

// 钥匙串
- (NSDictionary *)hadSetTouchIDUsersDic;
- (void)saveHadSetTouchIDUsersString:(NSString *)value;

// 弹出TouchID页面
- (void)presentTouchIDVC;

/**
*  TouchId 验证
*
*  @param localizedReason TouchId信息
*  @param title           验证错误按钮title
*  @param backSucces      成功返回Block
*  @param backFailure     失败返回Block
*/
- (void)evaluatePolicy:(NSString *)localizedReason
         fallbackTitle:(NSString *)title
          SuccesResult:(void(^)())backSucces
         FailureResult:(TouchIdValidationFailureBack)backFailure;

@end
