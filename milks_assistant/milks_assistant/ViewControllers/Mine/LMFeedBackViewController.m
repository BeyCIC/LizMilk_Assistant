//
//  LMFeedBackViewController.m
//  milks_assistant
//
//  Created by JasonHuang on 2017/5/7.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMFeedBackViewController.h"

@interface LMFeedBackViewController ()<UITextViewDelegate> {
    UIButton *placeLab;
    UITextView *inputText;
}

@end

@implementation LMFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"意见反馈";
    [self initView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
}

- (void)initView {
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15, 100, SCREEN_WIDTH - 30, 0.7)];
    line1.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    
    UITextField *userEmail = [[UITextField alloc] initWithFrame:CGRectMake(15, 105, SCREEN_WIDTH-30, 35)];
    userEmail.placeholder = @"填写邮箱";
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(15, 140, SCREEN_WIDTH - 30, 0.7)];
    line2.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    
    inputText = [[UITextView alloc] initWithFrame:CGRectMake(30, 145, SCREEN_WIDTH-60, 200)];
    inputText.delegate = self;
    inputText.font = [UIFont systemFontOfSize:16];
    placeLab = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 60)];

    [placeLab setTitle:@"请告诉我们您遇到的问题或想反馈的意见" forState:UIControlStateNormal];
    [placeLab setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateNormal];
    placeLab.titleLabel.font = [UIFont systemFontOfSize:16];
    placeLab.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    placeLab.userInteractionEnabled = YES;
    [inputText addSubview:placeLab];
    [placeLab addTarget:self action:@selector(beginEdit:) forControlEvents:UIControlEventTouchUpInside];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 150, SCREEN_WIDTH - 30, 0.7)];
    line3.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    
    UIButton *surebtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-40)/2, SCREEN_HEIGHT - 100, 40, 40)];
    [surebtn setBackgroundImage:[UIImage imageNamed:@"sure_black"] forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:line1];
    [self.view addSubview:userEmail];
    [self.view addSubview:line2];
    [self.view addSubview:inputText];
    [self.view addSubview:line3];
   
    [self.view addSubview:surebtn];
}

- (void)beginEdit:(id)sender {
 
    [inputText becomeFirstResponder];
}

- (void)sureAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"";
    }
    placeLab.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        placeLab.hidden = NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
