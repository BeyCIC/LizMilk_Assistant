//
//  LMModBoardViewController.m
//  milks_assistant
//
//  Created by JasonHuang on 2017/5/7.
//  Copyright © 2017年 JasonHuang. All rights reserved.
//

#import "LMAddBoardViewController.h"
#import "LizzieBoardDataInfo.h"

@interface LMAddBoardViewController ()<UITextViewDelegate> {
    UITextView *_editView;
    UIButton *sureBtn;
}

@end

@implementation LMAddBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _editView = [[UITextView alloc] initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 150)];
    _editView.delegate = self;
    _editView.textColor = [UIColor blackColor];
    
//    sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 250, SCREEN_WIDTH-60, 35)];
    sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-35)/2.0, 450,35, 35)];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"sure_btn"] forState:UIControlStateNormal];
//    [sureBtn setTitle:@"嗯，我写好了" forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 6;
    sureBtn.layer.masksToBounds = YES;
    
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_editView];
    [self.view addSubview:sureBtn];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sureAction:(UIButton*)sender {
    
    NSInteger LineCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"isDoubleLine"];
    if (![_editView.text isEqualToString:@""]) {
        LizzieBoardDataInfo *info = [[LizzieBoardDataInfo alloc] init];
        DashBoardModel *board = [[DashBoardModel alloc] init];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
        board.Did = strDate;
        board.title = _editView.text;
        board.color = @"#47838";
        if (LineCount == 2) {
            board.size_x = @"2";
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"isDoubleLine"];
        } else {
            board.size_x = @"1";
            [[NSUserDefaults standardUserDefaults] setInteger:(LineCount+1) forKey:@"isDoubleLine"];
        }
        
        board.size_y = @"1";
        
        [info addDiary:board];
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
