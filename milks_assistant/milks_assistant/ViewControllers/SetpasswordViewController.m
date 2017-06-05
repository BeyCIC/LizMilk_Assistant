//
//  SetpasswordViewController.m
//  AliPayDemo
//  爱你一生一世，刘磊璐
//  Create by JasonHuang on 15/7/15.
//  Copyright (c) 2015年 JasonHuang. All rights reserved.
//

#import "SetpasswordViewController.h"
#import "AliPayViews.h"
#import "KeychainData.h"

@interface SetpasswordViewController ()

@end

@implementation SetpasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /************************* start **********************************/
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(SCREEN_WIDTH - 80, 10, 64, 64);
    backBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [backBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    AliPayViews *alipay = [[AliPayViews alloc] initWithFrame:self.view.bounds];
    
    if ([self.string isEqualToString:@"验证密码"]) {
        alipay.gestureModel = ValidatePwdModel;
    } else if ([self.string isEqualToString:@"修改密码"]) {
        alipay.gestureModel = AlertPwdModel;
    } else if ([self.string isEqualToString:@"重置密码"]) {
        alipay.gestureModel = SetPwdModel;
    } else {
        alipay.gestureModel = NoneModel;
    }
    alipay.block = ^(NSString *pswString) {
        NSLog(@"设置密码成功-----你的密码为 = 【%@】\n\n", pswString);
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    [self.view addSubview:alipay];
    if ([self.string isEqualToString:@"验证密码"]) {
        alipay.gestureModel = ValidatePwdModel;
    } else if ([self.string isEqualToString:@"修改密码"]) {
        [self.view addSubview:backBtn];
    } else if ([self.string isEqualToString:@"重置密码"]) {
        [self.view addSubview:backBtn];
    } else {
        [self.view addSubview:backBtn];
    }
    /************************* end **********************************/
}

- (void)back  {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
