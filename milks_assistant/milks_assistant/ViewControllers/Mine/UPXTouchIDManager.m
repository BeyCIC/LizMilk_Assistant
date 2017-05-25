//
//  UPXTouchIDManager.m
//  wallet
//
//  Create by JasonHuang on 16/6/22.
//  Copyright © 2016年 JasonHuang. All rights reserved.
//

#import "UPXTouchIDManager.h"
#import "Util.h"
#import "KeychainItemWrapper.h"
#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

#define kUserKeyId [[NSString alloc] initWithFormat:@"%@%@",@"jason", @"lizzie"]

@implementation UPXTouchIDManager

+ (instancetype)sharedInstance {
    static UPXTouchIDManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UPXTouchIDManager alloc] init];
    });
    return instance;
}

#pragma mark - 当前设备TouchID是否可用
- (BOOL)isTouchIdAvailable {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        // 支持TouchID
        return YES;
    }
    // 不支持TouchID，包括没有设置TouchID或者没有设置解锁密码的设备
    return NO;
}

#pragma mark - 当前用户TouchID是否开着
- (BOOL)currentUserOpenTouchID {
    if (kUserKeyId) {
        NSDictionary *dic = [self hadSetTouchIDUsersDic];
        if (dic) {
            NSString *value = [dic valueForKey:kUserKeyId];
            if ([value isEqualToString:kHasSetTouchIDValue]) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - 当前用户TouchID是否设置过
- (BOOL)currentUserSetTouchID {
    if (kUserKeyId) {
        NSDictionary *dic = [self hadSetTouchIDUsersDic];
        if (dic) {
            NSString *value = [dic valueForKey:kUserKeyId];
            if (value) {
                return YES;
            }
        }
    }
    return NO;
}

#pragma mark - 钥匙串
// read from keychain
- (NSDictionary *)hadSetTouchIDUsersDic
{
    NSDictionary *result = nil;
    NSString *group = [NSString stringWithFormat:@"%@.%@",[Util bundleSeedID],[[NSBundle mainBundle] bundleIdentifier]];
    KeychainItemWrapper *accountWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:kTouchIDKeyChainIdentifer accessGroup:group];
    id msg = [accountWrapper objectForKey:(__bridge id)kKeyChainHadSetTouchIDUsersKey];
    if (!msg || [msg isEqualToString:@""]) {
        return nil;
    }
    
    NSData* data = [msg dataUsingEncoding:NSASCIIStringEncoding];
    result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    return result;
}
//{username:@"1or0"} save to keychain
- (void)saveHadSetTouchIDUsersString:(NSString *)value
{
    NSMutableDictionary *userDic = [[NSMutableDictionary alloc] init];
    userDic = [NSMutableDictionary dictionaryWithDictionary:[self hadSetTouchIDUsersDic]];
    
    [userDic setObject:value forKey:kUserKeyId];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *msgStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *group = [NSString stringWithFormat:@"%@.%@",[Util bundleSeedID],[[NSBundle mainBundle] bundleIdentifier]];
    KeychainItemWrapper *accountWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:kTouchIDKeyChainIdentifer accessGroup:group];
    
    [accountWrapper setObject:msgStr forKey:(__bridge id)kKeyChainHadSetTouchIDUsersKey];
}

#pragma mark - 弹出TouchID页面
- (void)presentTouchIDVC {
    if ([self shouldShowTouchID]) {
//        if (_touchIDVC) {
//            [_touchIDVC.view removeFromSuperview];
//        }
//        _touchIDVC = [[UPXTouchIDViewController alloc] init];
//        [_touchIDVC.view setFrame:CGRectMake(0, 0, UP_IPHONESIZE.width, UP_IPHONESIZE.height)];
//        [UP_App_KeyWindow addSubview:_touchIDVC.view];
    } else {
        [UP_NC postNotificationName:@"" object:@"TouchIDManager"];
    }    
}

- (BOOL)shouldShowTouchID {
    BOOL result = NO;

    //手势密码超时时间
//    NSTimeInterval interval = [UP_STR(@"String_LocalTimeoutInterval") doubleValue];

//    //从后台进入前台设置
//    if ((UP_SHDAT.hasLogin && ([UP_App backgroundInterval] >= interval))&& [self currentUserOpenTouchID]) {
//        result = YES;
//    }
    
    //第二次进入客户端时设置（非从后台进入前台）
//    if ((UP_SHDAT.hasLogin) && [self currentUserOpenTouchID])
//    {
//        //只有当tabbar初始化完成了才在这个入口启动手势密码
//        UITabBarController *aTabBarController = UP_App.rootViewController.tabBarController;
//        if ((aTabBarController.viewControllers.count == 0)||(!aTabBarController.viewControllers)) {
//            result = YES;
//        }
//    }
    
    return result;
}

#pragma mark - TouchId 验证
- (void)evaluatePolicy:(NSString *)localizedReason
         fallbackTitle:(NSString *)title
          SuccesResult:(void(^)())backSucces
         FailureResult:(TouchIdValidationFailureBack)backFailure {
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = title;
    //支持指纹验证
    [context evaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics
            localizedReason:localizedReason
                      reply:
     ^(BOOL succes, NSError *error) {
         if (succes) {
             //验证成功，返回主线程处理
             dispatch_async(dispatch_get_main_queue(), ^{
                 backSucces(succes);
             });
         } else {
             dispatch_async(dispatch_get_main_queue(), ^{
                 backFailure(error.code);
             });
         }
     }];
}

- (void)dealloc {
}

@end
