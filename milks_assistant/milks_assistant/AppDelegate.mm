//
//  AppDelegate.m
//  milks_assistant
//
//  Create by JasonHuang on 17/3/31.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "AppDelegate.h"
#import "DBConnection.h"
#import "Util.h"
#import "LMTouchIDManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self createTable];//创建数据库
    BOOL isLoad = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLoad"];
    if (!isLoad) {
         [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"isDoubleLine"];
    } else {
         [[NSUserDefaults standardUserDefaults] setInteger:YES forKey:@"firstLoad"];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];//手机上端的状态栏
    CGRect screenBounds = [[UIScreen mainScreen] bounds];//获取当前手机屏幕的边界大小
    UIWindow *window = [[UIWindow alloc] initWithFrame:screenBounds];//创建视窗，设置大小
    _rootViewController = [[WelcomeViewController alloc] init];//根视图管理器
    [window setRootViewController:_rootViewController];
    [window makeKeyAndVisible];//系统函数：让这个界面显示
    [self setWindow:window];
    
//    [[LMTouchIDManager sharedInstance] presentTouchIDVC];
//    if ([[LMTouchIDManager sharedInstance] isTouchIdAvailable]) {
//        //使用指纹解锁
//        [[LMTouchIDManager sharedInstance] evaluatePolicy: @"通过Home键验证已有手机指纹" fallbackTitle:@"" SuccesResult:^{
////            [wself.view removeFromSuperview];
//            //在手势密码完成之后绘制tab
////            [UP_NC postNotificationName:kNCAfterPatternAction object:@"TouchIDViewController"];
//        } FailureResult:^(LAError result){
//            //验证不成功或取消无操作
//        }];
//    }
//    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isEnterBackground"];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sholdShowGestValide" object:nil];
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//创建所有需要的表
- (void)createTable
{
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];//第三方库，用来存储数据；创建数据库
    [dbConnection readyDatabse];//
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    NSLog(@"cache dbVersion:%li",(long)[Util readNSUserDefaultsInt:dbVersion]);
    if ([Util readNSUserDefaultsInt:dbVersion] < dbVersionNew) {//版本低,删表
        [Util saveNSUserDefaults:dbVersion value:dbVersionNew];
        [dbConnection deleteTable:TABLE_NAME_DIARY];
        [dbConnection deleteTable:TABLE_NAME_BOARD];
    }
    
    
    if (![dbConnection isTableOK:TABLE_NAME_DIARY]) {//消息表
        [dbConnection createTable:TABLE_NAME_DIARY withArguments:@"userId text,userName text,diaryContent text,mood text,time text,location text"];
    }
    if (![dbConnection isTableOK:TABLE_NAME_BOARD]) {//消息表
        [dbConnection createTable:TABLE_NAME_BOARD withArguments:@"Did text,title text,color text,size_x text,size_y text"];
    }
    
    [[dbConnection DB] close];
}


@end
