//
//  AppDelegate.m
//  milks_assistant
//
//  Created by JasonHuang on 17/3/31.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "AppDelegate.h"
#import "DBConnection.h"
#import "Util.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self createTable];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIWindow *window = [[UIWindow alloc] initWithFrame:screenBounds];
    _rootViewController = [[WelcomeViewController alloc] init];
    [window setRootViewController:_rootViewController];
    [window makeKeyAndVisible];
    [self setWindow:window];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
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
    DBConnection *dbConnection = [[DBConnection alloc]initWithDBName:DB_NAME];
    [dbConnection readyDatabse];
    if (![[dbConnection DB] open]) {
        NSLog(@"数据库没有打开");
    }
    NSLog(@"cache dbVersion:%li",(long)[Util readNSUserDefaultsInt:dbVersion]);
    if ([Util readNSUserDefaultsInt:dbVersion] < dbVersionNew) {//版本低,删表
        [Util saveNSUserDefaults:dbVersion value:dbVersionNew];
        [dbConnection deleteTable:TABLE_NAME_DIARY];
    }
    
    if (![dbConnection isTableOK:TABLE_NAME_DIARY]) {//消息表
        [dbConnection createTable:TABLE_NAME_DIARY withArguments:@"seq text, mty text, acc text, f_ac text, m1 text, m2 text, m3 text, m4 text, m5 text, b1 text, b2 text, upt text, df text, pb text, pe text, time text"];
    }
    
    [[dbConnection DB] close];
}


@end
