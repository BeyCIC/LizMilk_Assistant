//
//  LMAddDairyViewController.m
//  milks_assistant
//
//  Created by Jason Huang on 17/4/4.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMAddDairyViewController.h"
#import "LizzieDairyDataInfo.h"

@interface LMAddDairyViewController () <UITextViewDelegate>{
    UITextView *_editView;
    UIButton *sureBtn;
}

@end

@implementation LMAddDairyViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView {
    
    _editView = [[UITextView alloc] initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 350)];
    _editView.delegate = self;
    _editView.textColor = [UIColor blackColor];
    
    sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-35)/2.0, 450,35, 35)];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"sure_btn"] forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 6;
    sureBtn.layer.masksToBounds = YES;
    
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_editView];
    [self.view addSubview:sureBtn];
    self.navigationItem.title = @"日记";
//    UIBarButtonItem *phoneButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_sure_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(sureAction:)];
//    self.navigationItem.rightBarButtonItem = phoneButton;
}

- (void)sureAction:(UIButton*)sender {
    
    if (![_editView.text isEqualToString:@""]) {
        LizzieDairyDataInfo *info = [[LizzieDairyDataInfo alloc] init];
        LizzieDiaryModel *dairy = [[LizzieDiaryModel alloc] init];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];

        dairy.userId = @"18801755762";
        dairy.userName = @"lizzie_liu";
        dairy.diaryContent = _editView.text;
        dairy.mood = @"忧郁";
        dairy.time = strDate;
        dairy.location = @"上海";
        [info addDiary:dairy];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)checkInput {
    
    if ([_editView.text isEqualToString:@""]) {
        [self showAlertWithTitle:@"提示" msg:@"亲爱的，请输入！" ok:@"就是不输入" cancel:@"OK,听你的"];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
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
