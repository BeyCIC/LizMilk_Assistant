//
//  LMAddDairyViewController.m
//  milks_assistant
//
//  Created by Jason Huang on 17/4/4.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMModDairyViewController.h"
#import "LizzieDairyDataInfo.h"

@interface LMModDairyViewController () <UITextViewDelegate>{
    UITextView *_editView;
    UIButton *sureBtn;
}

@end

@implementation LMModDairyViewController


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
    _editView.text = _dataInfo.diaryContent;
    sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-35)/2.0, 450,35, 35)];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"sure_btn"] forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 6;
    sureBtn.layer.masksToBounds = YES;
    
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_editView];
    [self.view addSubview:sureBtn];
}

- (void)sureAction:(UIButton*)sender {
    
    if (![_editView.text isEqualToString:@""]) {
        LizzieDairyDataInfo *info = [[LizzieDairyDataInfo alloc] init];

        _dataInfo.userId = @"18801755762";
        _dataInfo.userName = @"lizzie_liu";
        _dataInfo.diaryContent = _editView.text;
        _dataInfo.mood = @"忧郁";
        _dataInfo.location = @"上海";
        [info updateDiary:_dataInfo];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(modeFinished:)]) {
            [self.delegate modeFinished:_dataInfo];
        }
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
    UITouch *touch = [[event allTouches] anyObject];
    CGFloat ly = [touch locationInView:_editView].y;
    if (ly>=0 ) { //点标题栏也会消失，点其他地方捕捉不到了
        [self.view endEditing:YES];
    }
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
