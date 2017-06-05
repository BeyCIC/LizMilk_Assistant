//
//  WelcomeViewController.m
//
//  爱你一生一世，刘磊璐
//  Create by JasonHuang on 14-9-24.
//  Copyright (c) 2014年 JasonHuang. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LMMainViewController.h"
#import "LMMineViewController.h"
#import "LMDairyListViewController.h"
#import "DashBoardViewController.h"
#import "SetpasswordViewController.h"
#import "KeychainData.h"
#import "PhotoDIYViewController.h"


@interface WelcomeViewController()<UITabBarControllerDelegate>//协议：事件传递机制
{
    UIImageView* _welcomeImageView;//创建全局变量
}

@property (nonatomic, strong) UIImageView *dotImage;

@end


@implementation WelcomeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _welcomeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _welcomeImageView.image = [UIImage imageNamed:@"LaunchImage"];
    
    [self.view addSubview:_welcomeImageView];
    [self setupMainViewControllers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
}


#pragma mark - 微信唤醒

- (void)openMineTab
{
    for(UIViewController * vc in self.childViewControllers) {
        if([vc isKindOfClass:[HYSTabBarViewController class]]) {
            HYSTabBarViewController * tabVC = (HYSTabBarViewController *)vc;
            tabVC.selectedIndex = 4; // “我的”Tab
            break;
        }
    }
}

#pragma mark - 创建Wallet首页的UITabBarController

- (void)setupMainViewControllers
{
    // 设置UITabBar样式
    [[UITabBar appearance] setSelectionIndicatorImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    
    NSDictionary * attributesForNormal = nil;//正常状态下
    NSDictionary * attributesForSelected = nil;//选中状态下
    // only iOS7
    attributesForNormal = @{NSForegroundColorAttributeName:UP_COL_RGB(0xb9b9b9), NSFontAttributeName:[UIFont systemFontOfSize:11]};
    
    attributesForSelected = @{NSForegroundColorAttributeName:UP_COL_RGB(0x333333), NSFontAttributeName:[UIFont systemFontOfSize:11]};
    
    [[UITabBarItem appearance] setTitleTextAttributes:attributesForNormal forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:attributesForSelected forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    
    _tabBarController = [[HYSTabBarViewController alloc] init];
    _tabBarController.delegate = self;
    _tabBarController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView animateWithDuration:1 animations:^{
        _welcomeImageView.layer.opacity = 0.0f;//画布设为透明
    } completion:^(BOOL finished) {
        if (finished)
        {
            [_welcomeImageView removeFromSuperview];
        }
    }];
    
    [self.view insertSubview:_tabBarController.view belowSubview:_welcomeImageView];
    [self addChildViewController:_tabBarController];
    [self fillTheTabViewControllersContent];
}

- (void)fillTheTabViewControllersContent
{
    // 获取tab标题数组
    NSArray* tabItems = @[@"Note",@"Retouch",@"Diary",@"Mine"];
    
    // feature
    DashBoardViewController* mainVC = [[DashBoardViewController alloc] init];
    UINavigationController* firstNavi = [[UINavigationController alloc] initWithRootViewController:mainVC];//便签页设置导航控制器
    firstNavi.tabBarItem = [self tabBarItemWithTitle:tabItems[0] selectedImage:@"tab1_hl" unselectedImageName:@"tab1"];
    
    PhotoDIYViewController* photoVC = [[PhotoDIYViewController alloc] init];
    UINavigationController* photoNavi = [[UINavigationController alloc] initWithRootViewController:photoVC];
    photoNavi.tabBarItem = [self tabBarItemWithTitle:tabItems[1] selectedImage:@"tab5_hl" unselectedImageName:@"tab5"];

    
    // coupon
    LMDairyListViewController* dairyVC2 = [[LMDairyListViewController alloc] init];
    UINavigationController* secondNavi = [[UINavigationController alloc] initWithRootViewController:dairyVC2];
    secondNavi.tabBarItem = [self tabBarItemWithTitle:tabItems[2] selectedImage:@"tab2_hl" unselectedImageName:@"tab2_hl"];

    
    // life
    LMMineViewController* lifeVC = [[LMMineViewController alloc] init];
    UINavigationController* thirdNavi = [[UINavigationController alloc] initWithRootViewController:lifeVC];
    thirdNavi.tabBarItem = [self tabBarItemWithTitle:tabItems[3] selectedImage:@"tab6_hl" unselectedImageName:@"tab6_hl"];
    _tabBarController.viewControllers = @[firstNavi,photoNavi,secondNavi,thirdNavi];
}

- (UITabBarItem*)tabBarItemWithTitle:(NSString*)title selectedImage:(NSString*)selectedImageName unselectedImageName:(NSString*)unselectedImageName//函数封装，便于调用
{
    // only iOS7
    UIImage* selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* unselectedImage = [[UIImage imageNamed:unselectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:unselectedImage selectedImage:selectedImage];
//    tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
    return tabBarItem;
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}


@end


