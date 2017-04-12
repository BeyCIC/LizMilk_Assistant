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
    
    _editView = [[UITextView alloc] initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 150)];
    _editView.delegate = self;
    _editView.textColor = [UIColor blackColor];
    
    sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 250, SCREEN_WIDTH-60, 35)];
    [sureBtn setTitle:@"嗯，我写好了" forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 6;
    sureBtn.layer.masksToBounds = YES;
    
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_editView];
    [self.view addSubview:sureBtn];
}

- (void)sureAction:(UIButton*)sender {
    
    if ([self checkInput]) {
        LizzieDairyDataInfo *info = [[LizzieDairyDataInfo alloc] init];
        LizzieDiaryModel *dairy = [[LizzieDiaryModel alloc] init];
        dairy.userId = @"18801755762";
        dairy.userName = @"lizzie_liu";
        dairy.diaryContent = _editView.text;
        dairy.mood = @"忧郁";
        dairy.time = @"20170412";
        dairy.location = @"上海";
        [info addDiary:dairy];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
    }
}

- (BOOL)checkInput {
    
//    @property (nonatomic, copy) NSString<Optional>* diaryContent;
//    @property (nonatomic, copy) NSString<Optional>* mood;
//    @property (nonatomic, copy) NSString<Optional>* time;
//    @property (nonatomic, copy) NSString<Optional>* location;

    if ([_editView.text isEqualToString:@""]) {
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
