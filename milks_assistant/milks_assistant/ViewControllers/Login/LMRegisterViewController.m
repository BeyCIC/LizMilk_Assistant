//
//  LMRegisterViewController.m
//  milks_assistant
//
//  Created by JasonHuang on 2017/5/7.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMRegisterViewController.h"
#import <CoreText/CoreText.h>

@interface LMRegisterViewController () {
    
    UITextField *userText;
    UITextField *pwdText;
}

@end

@implementation LMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView {
    
    NSInteger offsetY = 100;
    self.view.backgroundColor = [UIColor whiteColor];
    userText = [[UITextField alloc] initWithFrame:CGRectMake(30, offsetY, SCREEN_WIDTH-60, 30)];
    userText.placeholder = @"请输入邮箱";
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(30, offsetY + 30, SCREEN_WIDTH-60, 0.7)];
    line1.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    pwdText = [[UITextField alloc] initWithFrame:CGRectMake(30, offsetY + 50, SCREEN_WIDTH-60, 30)];
    pwdText.placeholder = @"请输入密码";
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(30, offsetY + 80, SCREEN_WIDTH-60, 0.7)];
    line2.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-140)/2, offsetY + 110, 140, 40)];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:RGBCOLOR(29, 195, 38)];
    [registerBtn addTarget:self action:@selector(register:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *switchLab = [[UILabel alloc] initWithFrame:CGRectMake(30, offsetY + 170, SCREEN_WIDTH - 60, 20)];
    switchLab.text = @"或者";
    switchLab.textAlignment = NSTextAlignmentCenter;
    switchLab.textColor = [UIColor grayColor];
    switchLab.font = [UIFont systemFontOfSize:15];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"立即登录"];
    [attString addAttribute:(NSString*)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:kCTUnderlineStyleSingle] range:(NSRange){0,[attString length]}];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, offsetY + 210, 80, 30)];
//    [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn setAttributedTitle:attString forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(gotologin:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *shareBtn  = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-220)/2, SCREEN_HEIGHT - 120, 220, 63)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:userText];
    [self.view addSubview:line1];
    [self.view addSubview:pwdText];
    [self.view addSubview:line2];
    [self.view addSubview:registerBtn];
    [self.view addSubview:switchLab];
    [self.view addSubview:loginBtn];
    [self.view addSubview:shareBtn];
    
    
}

- (void)register:(UIButton*)sender {
    
    if ([userText.text isEqualToString:@""] || [pwdText.text isEqualToString:@""]) {
        [self showAlertWithTitle:@"提示" msg:@"请输入" ok:nil cancel:@"确定"];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setValue:userText.text forKey:LoginUserName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if(self.delegate && [self.delegate respondsToSelector:@selector(registerSuc)]) {
        [self.delegate registerSuc];
    }
}

- (void)gotologin:(UIButton*)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(loginBtnaction)]) {
        [self.delegate loginBtnaction];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
