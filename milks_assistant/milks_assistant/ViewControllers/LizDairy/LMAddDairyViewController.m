//
//  LMAddDairyViewController.m
//  milks_assistant
//
//  Created by Jason Huang on 17/4/4.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMAddDairyViewController.h"

@interface LMAddDairyViewController () <UITextViewDelegate>{
    UITextView *_editView;
    UIButton *sureBtn;
}

@end

@implementation LMAddDairyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initView {
    
    _editView = [[UITextView alloc] initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 150)];
    _editView.delegate = self;
    _editView.textColor = [UIColor blackColor];
    
    sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 250, SCREEN_WIDTH-60, 35)];
    [sureBtn setTitle:@"嗯，我写好了" forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 6;
    sureBtn.layer.masksToBounds = YES;
    
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_editView];
    [self.view addSubview:sureBtn];
}

- (void)sureAction:(UIButton*)sender {
    
    if ([self checkInput]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
    }
}

- (BOOL)checkInput {
    
    if ([_editView.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
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
