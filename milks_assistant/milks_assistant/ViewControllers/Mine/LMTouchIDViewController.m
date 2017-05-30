//
//  LMTouchIDViewController.m
// 
//
//  Created by JasonHuang on 17/5/22.
//  Copyright © 2016年 JasonHuang All rights reserved.
//

#import "LMTouchIDViewController.h"
#import "LMTouchIDManager.h"
#import "AppDelegate.h"

#define kNormalBtnTitleColor UP_COL_RGB(0x158cfb)   //UP_COL_RGB(0x878ac2)

@implementation LMTouchIDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.currentUserName = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserName];
    
    [self hideKeyBoard];
    
    [self useTouchID];
}

//隐藏所有键盘：//隐藏所有ActionSheet
- (void)hideKeyBoard
{
    for (UIWindow* window in [UIApplication sharedApplication].windows)
    {
        [window endEditing:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    bgView.backgroundColor = UP_COL_RGB(0xffffff);
    [bgView setUserInteractionEnabled:YES];
    [self.view addSubview:bgView];
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    CGRect infoLabelFrame = CGRectZero;
    _headImg = [[UIImageView alloc]init];
    [_headImg setBackgroundColor:[UIColor clearColor]];
    _headImg.frame = CGRectMake(bgView.center.x, UPFloat(100), UPFloat(62), _headImg.frame.size.width);
    [bgView addSubview:_headImg];
//     setRoundedView(_headImg, _headImg.frame.size.width);
    if ([self readFaceImage])
    {
        _headImg.bounds = CGRectMake(0, UPFloat(40), UPFloat(73), UPFloat(73));
        _headImg.layer.cornerRadius = UPFloat(73)/2.0;
        _headImg.layer.masksToBounds = YES;
        [_headImg setCenter:CGPointMake(bgView.center.x,  _headImg.center.y)];
        [_headImg setImage:[self readFaceImage]];
    }
    
    [userNameLabel setFrame:CGRectMake(0, CGRectGetMaxY(_headImg.frame)+UPFloat(10), CGRectGetWidth(bgView.frame), UPFloat(20))];
    [userNameLabel setCenter:CGPointMake(bgView.center.x, userNameLabel.center.y)];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    [userNameLabel setTextAlignment:NSTextAlignmentCenter];
    [userNameLabel setTextColor:UP_COL_RGB(0x333333)];
    [userNameLabel setFont:[UIFont systemFontOfSize:UPFloat(16)]];
    
    NSString* userNickname = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNickName];
    if (!userNickname || [userNickname isEqualToString:@""]) {
        userNickname = @"Lizzie liu";
    }
    [userNameLabel setText:userNickname];
    [bgView addSubview:userNameLabel];
    
    infoLabelFrame = CGRectMake(0, CGRectGetMaxY(userNameLabel.frame)+UPFloat(20), CGRectGetWidth(bgView.frame), UPFloat(20));
    
    if (!IS_IPHONE_5 && !IS_IPHONE_6 && !IS_IPHONE_6PLUS) {
        infoLabelFrame.origin.y -= UPFloat(10);
    }
    
    CGFloat y = CGRectGetHeight(bgView.frame)-40-20;
    if (!IS_IPHONE_5 && !IS_IPHONE_6 && !IS_IPHONE_6PLUS) {
        y = CGRectGetHeight(bgView.frame)-UPFloat(30);
    }
    
    UIImageView *logoImgView = [[UIImageView alloc] init];

    logoImgView.frame = CGRectMake(0, 0, 70, 70);
    [logoImgView setCenter:bgView.center];
    [logoImgView setImage:[UIImage imageNamed:@"touchID_logo"]];
    [bgView addSubview:logoImgView];
    
    //登录其他账户
    UIButton *otherAccountLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherAccountLoginBtn setFrame:CGRectMake(kScreenWidth/2-75, kScreenHeight-30, 150, 30)];
    [otherAccountLoginBtn setTitle:@"登录其他账户" forState:UIControlStateNormal];
    [otherAccountLoginBtn addTarget:self action:@selector(loginOtherAccount) forControlEvents:UIControlEventTouchUpInside];
    [otherAccountLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [otherAccountLoginBtn setTitleColor:kNormalBtnTitleColor forState:UIControlStateNormal];
    [bgView addSubview:otherAccountLoginBtn];
    
    //使用指纹解锁
    UIButton *touchIDBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [touchIDBtn setFrame:CGRectMake(0, CGRectGetMinY(logoImgView.frame), kScreenWidth, logoImgView.frame.size.height + 50)];
    [touchIDBtn setTitle:@"指纹解锁" forState:UIControlStateNormal];
    [touchIDBtn addTarget:self action:@selector(useTouchID) forControlEvents:UIControlEventTouchUpInside];
    [touchIDBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [touchIDBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [touchIDBtn setTitleColor:kNormalBtnTitleColor forState:UIControlStateNormal];
    [bgView addSubview:touchIDBtn];

}

- (void)useTouchID {
//    [UP_NC removeObserver:self name:kNCEnterForeground object:nil];
    __weak LMTouchIDViewController *wself = self;
    if ([[LMTouchIDManager sharedInstance] isTouchIdAvailable]) {
        //使用指纹解锁
        [[LMTouchIDManager sharedInstance] evaluatePolicy: @"通过Home键验证已有手机指纹" fallbackTitle:@"" SuccesResult:^{
            [wself.view removeFromSuperview];
            //在手势密码完成之后绘制tab
//            [UP_NC postNotificationName:kNCAfterPatternAction object:@"TouchIDViewController"];
        } FailureResult:^(LAError result){
            //验证不成功或取消无操作
        }];
    } else {
    }
}

- (UIImage*)readFaceImage
{

    UIImage *userHeaderImg;
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserHeader];
    if (imageData) {
        userHeaderImg = [UIImage imageWithData:imageData];
    }
    if (!userHeaderImg) {
        userHeaderImg = [UIImage imageNamed:@"lizhead"];
    }
    return userHeaderImg;
}


- (void)appEnterForeground {
    [self useTouchID];

}

- (void)loginOtherAccount{
    [self.view removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TouchIDManagerOtherAccount" object:nil];
}

//把方形button或view变成圆形
void setRoundedView(id obj,float newSize)
{
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(newSize/2, newSize/2) radius:newSize/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    CAShapeLayer * shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    shape.lineWidth = 0.2;
    
    if ([obj isKindOfClass:[UIButton class]])
    {
        UIButton * targetobj = (UIButton *)obj;
        targetobj.layer.mask = shape;
    }
    else if([obj isKindOfClass:[UIView class]])
    {
        UIView * targetobj = (UIView *)obj;
        targetobj.layer.mask = shape;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    WelcomeViewController *vc = UP_App.rootViewController;
    if (vc.tabBarController.viewControllers.count > 0 && vc.tabBarController.selectedIndex == 0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
    }
}

@end
