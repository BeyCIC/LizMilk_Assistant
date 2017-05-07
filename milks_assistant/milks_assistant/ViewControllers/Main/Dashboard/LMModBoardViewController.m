//
//  LMModBoardViewController.m
//  milks_assistant
//
//  Created by JasonHuang on 2017/5/7.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMModBoardViewController.h"
#import "LizzieBoardDataInfo.h"

@interface LMModBoardViewController ()<UITextViewDelegate> {
    UITextView *_editView;
    UIButton *sureBtn;
}

@end

@implementation LMModBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _editView = [[UITextView alloc] initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 150)];
    _editView.delegate = self;
    _editView.textColor = [UIColor blackColor];
    _editView.text = _dashInfo.title;
//    sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 250, SCREEN_WIDTH-60, 35)];
    sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-35)/2.0, 450,35, 35)];
//    [sureBtn setTitle:@"嗯，我写好了" forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"sure_btn"] forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 6;
    sureBtn.layer.masksToBounds = YES;
    
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_editView];
    [self.view addSubview:sureBtn];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sureAction:(UIButton*)sender {
    
    if (![_editView.text isEqualToString:@""]) {
        LizzieBoardDataInfo *info = [[LizzieBoardDataInfo alloc] init];
        
        
        _dashInfo.title = _editView.text;
        _dashInfo.color = @"#47838";
        _dashInfo.size_x = @"1";
        _dashInfo.size_y = @"1";
        [info updateDashBoard:_dashInfo];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        [self showAlertWithTitle:@"提示" msg:@"请输入内容" ok:@"" cancel:@""];
    }
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
